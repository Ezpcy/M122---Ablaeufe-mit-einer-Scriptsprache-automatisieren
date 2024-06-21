#!/bin/bash

# Pfad zu den Verzeichnissen
schulklassen_dir="./_schulklassen"
templates_dir="./_templates"

# Gehe durch alle .txt-Dateien im Verzeichnis "_schulklassen"
for klasse_file in "$schulklassen_dir"/*.txt; do
    # Erhalte den Basisnamen der Datei ohne Pfad und Extension für das Verzeichnis
    klasse_dir="${klasse_file%.txt}"  # Entfernt .txt
    klasse_dir="${klasse_dir##*/}"    # Entfernt den Pfad

    # Erstelle ein Verzeichnis für die Klasse, wenn es nicht existiert
    mkdir -p "$schulklassen_dir/$klasse_dir"

    # Lese jede Zeile in der Datei
    while IFS= read -r schueler_name; do
        # Erstelle ein Verzeichnis für jeden Schüler innerhalb des Klassenverzeichnisses
        schueler_dir="$schulklassen_dir/$klasse_dir/$schueler_name"
        mkdir -p "$schueler_dir"

        # Kopiere alle Inhalte aus "_templates" in das Schülerverzeichnis
        cp -a "$templates_dir/." "$schueler_dir/"
    done < "$klasse_file"
done

echo "Verarbeitung abgeschlossen. Dateien wurden verteilt."
