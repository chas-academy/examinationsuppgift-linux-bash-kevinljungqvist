#!/bin/bash

# ==========================================================
# Script Name: create_users.sh
# Description:
#   Skapar användare från argument, bygger katalogstruktur,
#   sätter rättigheter och genererar en personlig welcome.txt.
#
# Usage:
#   sudo ./create_users.sh Anna Bjorn Charlie
# ==========================================================

set -Eeuo pipefail
set -o pipefail

readonly REQUIRED_DIRS=("Documents" "Downloads" "Work")

print_error() {
    local message
    message="${1:-Unknown error}"

    printf '[ERROR] %s\n' "$message" >&2
}

print_info() {
    local message
    message="${1:-}"

    printf '[INFO] %s\n' "$message"
}

check_root() {
    if [[ "${EUID}" -ne 0 ]]; then
        print_error "Detta script måste köras som root."
        return 1
    fi
}

validate_arguments() {
    if [[ "$#" -eq 0 ]]; then
        print_error "Inga användarnamn angavs."
        printf 'Usage: %s <user1> <user2> ...\n' "$0" >&2
        return 1
    fi
}

sanitize_username() {
    local username
    username="${1:-}"

    if [[ ! "$username" =~ ^[a-zA-Z][a-zA-Z0-9_-]{0,31}$ ]]; then
        print_error "Ogiltigt användarnamn: $username"
        return 1
    fi
}

create_group_if_missing() {
    local group_name
    group_name="${1:-}"

    if getent group "$group_name" >/dev/null 2>&1; then
        return 0
    fi

    if ! groupadd "$group_name"; then
        print_error "Kunde inte skapa grupp: $group_name"
        return 1
    fi
}

create_user() {
    local username
    username="${1:-}"

    if id "$username" >/dev/null 2>&1; then
        print_info "Användaren $username finns redan. Hoppar över skapande."
        return 0
    fi

    if ! useradd -m -s /bin/bash -g "$username" "$username"; then
        print_error "Kunde inte skapa användaren: $username"
        return 1
    fi

    print_info "Användare skapad: $username"
}

create_user_directories() {
    local username
    local home_dir
    local dir

    username="${1:-}"
    home_dir="/home/$username"

    for dir in "${REQUIRED_DIRS[@]}"; do
        if ! mkdir -p "$home_dir/$dir"; then
            print_error "Kunde inte skapa katalog: $home_dir/$dir"
            return 1
        fi
    done

    if ! chown -R "$username:$username" "$home_dir"; then
        print_error "Kunde inte sätta ägare på hemkatalogen för $username"
        return 1
    fi

    if ! chmod 700 "$home_dir"; then
        print_error "Kunde inte sätta rättigheter på $home_dir"
        return 1
    fi

    for dir in "${REQUIRED_DIRS[@]}"; do
        if ! chmod 700 "$home_dir/$dir"; then
            print_error "Kunde inte sätta rättigheter på $home_dir/$dir"
            return 1
        fi
    done
}

generate_welcome_file() {
    local username
    local home_dir
    local welcome_file
    local users_list

    username="${1:-}"
    home_dir="/home/$username"
    welcome_file="$home_dir/welcome.txt"

    if ! users_list=$(cut -d: -f1 /etc/passwd | grep -v "^${username}$"); then
        print_error "Kunde inte hämta användarlista."
        return 1
    fi

    {
        printf 'Välkommen %s\n\n' "$username"
        printf 'Andra användare i systemet:\n'
        printf '%s\n' "$users_list"
    } > "$welcome_file"

    if ! chown "$username:$username" "$welcome_file"; then
        print_error "Kunde inte ändra ägare på $welcome_file"
        return 1
    fi

    if ! chmod 600 "$welcome_file"; then
        print_error "Kunde inte sätta rättigheter på $welcome_file"
        return 1
    fi
}

process_user() {
    local username
    username="${1:-}"

    if ! sanitize_username "$username"; then
        return 1
    fi

    if ! create_group_if_missing "$username"; then
        return 1
    fi

    if ! create_user "$username"; then
        return 1
    fi

    if ! create_user_directories "$username"; then
        return 1
    fi

    if ! generate_welcome_file "$username"; then
        return 1
    fi

    print_info "Konfiguration klar för användaren: $username"
}

main() {
    local username

    if ! check_root; then
        return 1
    fi

    if ! validate_arguments "$@"; then
        return 1
    fi

    for username in "$@"; do
        if ! process_user "$username"; then
            print_error "Fel vid hantering av användaren: $username"
        fi
    done
}

main "$@"
