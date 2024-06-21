#!/bin/bash

# Pfadvariablen definieren
csv_dir="./csv_output"
brf_dir="./brf_output"
date_stamp=$(date '+%Y-%m-%d_%H-%M')
archive_name="${date_stamp}_newMailadr_Klasse_Nachname.zip"

# Verzeichnisse erstellen
mkdir -p "$csv_dir" "$brf_dir"

# Dateinamen für die CSV-Datei
output_file="${csv_dir}/$(date '+%Y-%m-%d_%H-%M')_email_passwords.csv"
input_file="./mock_data.csv"
current_date=$(date '+%d.%m.%Y')

# Passwortgenerierungsfunktion
generate_password() {
    tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 12
}

# Namen normalisieren
normalize_name() {
    echo "$1" | iconv -f UTF-8 -t ASCII//TRANSLIT | sed 's/[^A-Za-z0-9]//g' | tr 'A-Z' 'a-z'
}

# Dublettenliste und Zähler
declare -A name_count

# Kopfzeile für CSV-Datei
echo "Email;Password" > "$output_file"

# Datei lesen und Inhalt verarbeiten
tail -n +2 "$input_file" | while IFS=',' read -r id Vorname Nachname Gender Strasse StrNummer PLZ Ort other
do
    # Namen normalisieren
    norm_firstname=$(normalize_name "$Vorname")
    norm_lastname=$(normalize_name "$Nachname")
    full_name="${norm_firstname}.${norm_lastname}"

    # Dublettenprüfung und E-Mail-Adresse generieren
    if [[ -z ${name_count[$full_name]} ]]; then
        name_count[$full_name]=1
    else
        name_count[$full_name]=$((name_count[$full_name]+1))
        full_name="${full_name}${name_count[$full_name]}"
    fi

    email="${full_name}@edu.tbz.ch"
    password=$(generate_password)
    echo "${email};${password}" >> "$output_file"

    # Anrede basierend auf Geschlecht
    anrede="Liebe(r)"
    [[ "$Gender" == "Male" ]] && anrede="Lieber"
    [[ "$Gender" == "Female" ]] && anrede="Liebe"

    # Briefdatei erstellen
    brf_file="${brf_dir}/${email}.brf"
    cat <<EOF > "$brf_file"
Technische Berufsschule Zürich
Ausstellungsstrasse 70
8005 Zürich

Zürich, den $current_date

                        $Vorname $Nachname
                        $Strasse $StrNummer
                        $PLZ $Ort

$anrede $Vorname

Es freut uns, Sie im neuen Schuljahr begrüssen zu dürfen.

Damit Sie am ersten Tag sich in unsere Systeme einloggen
können, erhalten Sie hier Ihre neue Emailadresse und Ihr
Initialpasswort, das Sie beim ersten Login wechseln müssen.

Emailadresse:   $email
Passwort:       $password

Mit freundlichen Grüssen

Max Mustermann
(TBZ-IT-Service)

admin.it@tbz.ch, Abt. IT: +41 44 446 96 60
EOF

done

echo "Generated files in $csv_dir and $brf_dir."

# Archiv erstellen
zip -r "$archive_name" "$csv_dir" "$brf_dir"
