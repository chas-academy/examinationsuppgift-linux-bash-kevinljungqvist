#!/bin/bash

# ==========================================
# Script för att skapa användare
# Skapar:
# - användare
# - hemkatalog
# - mappar
# - welcome.txt
# ==========================================

# Kontrollera att scriptet körs som root
if [ "$EUID" -ne 0 ]; then
    echo "Fel: Du måste köra scriptet som root."
    exit 1
fi

# Kontrollera att minst en användare skickats in
if [ $# -eq 0 ]; then
    echo "Användning: $0 användare1 användare2 ..."
    exit 1
fi

# Loopa igenom alla användarnamn
for USERNAME in "$@"
do
    echo "Skapar användare: $USERNAME"

    # Skapa användaren med hemkatalog
    useradd -m "$USERNAME"

    # Sätt sökväg till hemkatalog
    HOME_DIR="/home/$USERNAME"

    # Skapa undermappar
    mkdir -p "$HOME_DIR/Documents"
    mkdir -p "$HOME_DIR/Downloads"
    mkdir -p "$HOME_DIR/Work"

    # Sätt ägare på mapparna
    chown -R "$USERNAME:$USERNAME" "$HOME_DIR"

    # Endast ägaren får läsa/skriva
    chmod 700 "$HOME_DIR/Documents"
    chmod 700 "$HOME_DIR/Downloads"
    chmod 700 "$HOME_DIR/Work"

    # Skapa welcome.txt
    WELCOME_FILE="$HOME_DIR/welcome.txt"

    echo "Välkommen $USERNAME" > "$WELCOME_FILE"
    echo "" >> "$WELCOME_FILE"
    echo "Andra användare i systemet:" >> "$WELCOME_FILE"

    # Lista alla användare
    cut -d: -f1 /etc/passwd >> "$WELCOME_FILE"

    # Sätt rätt ägare
    chown "$USERNAME:$USERNAME" "$WELCOME_FILE"

    echo "Användare $USERNAME skapad."
done

echo "Klart!"
