[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/Sk6t7KfR)
# 🎓 Linux & Bash: Skapa Användarhanterings-script

Välkommen till detta prov i **Linux & Bash**! Din uppgift är att **skapa ett automatiserat Bash-script som hanterar skapandet av nya användare och sätter upp deras katalogstruktur**.

---

## ⚠️ VIKTIGT: LÄS DETTA FÖRST

För att din inlämning ska fungera och rättas korrekt måste du följa dessa regler:

1.  **Rör ej systemfiler:** Du får **inte** göra ändringar i mappen `.github`, eller i testfilerna. Om du ändrar dessa filer blir ditt prov ogiltigförklarat.
2.  **Registrering:** Du måste fylla i ditt ID i `student.json` innan du börjar (se nedan).
3.  **Inlämningsstatus:** Du styr själv när du är "klar" genom en inställning i `student.json`.
4.  Se till att feedback bottens rapporterade testresultat är det du vill ha, om den inte visar rätt så har du något fel i din kod.

---

## 🆔 Steg 1: Setup & ID

Innan du börjar koda **måste** du ställa in ditt projekt. Om du inte gör detta kommer inga av dina tester att köras.

**Så här hittar du ditt ID:**

1.  Logga in på antagningssidan (yh-antagning.se).
2.  Under "Inlämnade ansökningar", klicka på rutan för denna utbildning.
3.  Scrolla längst ner på sidan till sektionen **"Mina personuppgifter"** (klicka på pilen för att fälla ut om det behövs).
4.  Kopiera koden som står vid **Ansökningsnummer** (t.ex. `FSAEFSAD`).

**Så här ställer du in repot:**

1.  Öppna filen `student.json` i din kodeditor.
2.  Byt ut texten `"SKRIV_DITT_ID_HÄR"` mot ditt ID.
3.  Låt `"submitted": false` vara kvar. Detta betyder att du jobbar på ett **utkast**.
4.  Spara filen.

```
{
  "student_id": "SKRIV_DITT_ID_HÄR",
  "submitted": false
}
```

---

## 📝 Uppgiftsbeskrivning

**Fil att arbeta i:** `create_users.sh`

**Scenario:** Företaget växer och du behöver ett script som skapar en användare, sätter upp en hemkatalog och tilldelar rätt grupp. Du ska skapa ett script som konfigurerar och skapar användare utifrån en lista som skickas in till scriptet.

Scriptet ska hantera säkerhet (endast root får köra det), skapa specifika undermappar för varje användare och generera en personlig välkomstfil.

Totalt kan du få **100 poäng** på provet.

### Funktionella Krav

Din kod kommer att rättas automatiskt baserat på följande krav:

#### 1\. Grundstruktur och Behörighet (20p)

- **(10p)** Scriptet ska ha en korrekt "Shebang" (`#!/bin/bash`) och innehålla kommentarer som förklarar koden.
- **(10p)** Scriptet ska kontrollera att användaren som kör scriptet är **root** (Superuser / UID 0). Om inte, ska scriptet avbrytas med ett felmeddelande.

#### 2\. Användarskapande (20p)

- **(20p)** Scriptet ska kunna ta emot en lista av användarnamn som argument (parametrar) och skapa dessa användare på systemet (t.ex. `useradd`).
  - _Exempelanrop:_ `./create_users.sh Anna Bjorn Charlie`

#### 3\. Katalogstruktur och Rättigheter (20p)

- **(10p)** För varje ny användare ska mapparna `Documents`, `Downloads` och `Work` skapas i deras hemkatalog.
- **(10p)** Se till att endast ägaren av mapparna kan redigera och läsa i dem.

#### 4\. Välkomstmeddelande (20p)

- **(20p)** Filen `welcome.txt` ska skapas i användarens hemkatalog. Denna fil ska innehålla:
  1.  Första raden ska innehålla ett personligt välkomstmeddelande i detta format: `Välkommen <användare>`
  2.  En lista på alla andra användare som redan finns i systemet.

---

## Inlämning & Video (20p)

Förutom koden ska du spela in en kort skärminspelning där du demonstrerar din lösning.

1.  Spela in när du visar din lösning och berättar om hur den fungerar.
2.  Döp filen till exakt: `videoprov.mp4`.
3.  Lägg filen i rotmappen (samma ställe som denna README).
4.  **OBS:** Filen får inte vara större än 100MB.

---

## 🚀 Hur du testar din kod

Detta projekt använder automatisk rättning. Du har två sätt att se dina poäng:

### Alternativ 1: Köra lokalt (Rekommenderas)

För att slippa vänta på GitHub kan du köra testerna på din egen dator med
`sudo .github/tests/test.sh`. Alternativt `sudo .github/tests/test.sh 1` för att välja specifika testfall

### Alternativ 2: GitHub Feedback

När du gör en `git push` kommer GitHub att köra testerna.

1.  Gå till ditt repo på GitHub.
2.  Klicka på fliken **Pull Requests**.
3.  Öppna feedback-tråden.
4.  En bot kommer att posta/uppdatera en tabell med dina resultat.

> **OBS:** Så länge `submitted` är `false` kommer GitHub visa ett **Rött Kryss** (Failed) på inlämningen. Detta är normalt och betyder bara att det är ett "Arbete pågår".

---

## ✅ Steg 2: Inlämning

När du känner dig klar och har fått de poäng du satsar på:

1.  Öppna `student.json`.
2.  Ändra `"submitted": false` till `"submitted": true`.
3.  Spara, committa och pusha till GitHub.

```
{
  "student_id": "SKRIV_DITT_ID_HÄR",
  "submitted": true
}
```

Nu (om du klarat alla obligatoriska krav) ska du få en **Grön Bock** ✅ på GitHub och botten kommer skriva "INLÄMNING MOTTAGEN".

---

### Lycka till! 🌟
