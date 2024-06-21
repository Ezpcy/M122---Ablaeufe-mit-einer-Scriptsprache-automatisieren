#!/bin/bash

# Pfad
schulklassen_dir="./_schulklassen"
templates_dir="./_templates"

# Druch die Text Files gehen
for klasse_file in "$schulklassen_dir"/*.txt; do
    # Basis Namen parsen
    klasse_dir="${klasse_file%.txt}"  
    klasse_dir="${klasse_dir##*/}"    

    # Verzeichnis erstellen
    mkdir -p "$schulklassen_dir/$klasse_dir"

    # Zeilen einlesen
    while IFS= read -r schueler_name; do
        # Für Schüler Verzeichnis erstellen
        schueler_dir="$schulklassen_dir/$klasse_dir/$schueler_name"
        mkdir -p "$schueler_dir"

        # Inhalt von templates kopieren
        cp -a "$templates_dir/." "$schueler_dir/"
    done < "$klasse_file"
done

echo "Fertig."
