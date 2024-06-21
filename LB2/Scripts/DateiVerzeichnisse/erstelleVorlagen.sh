#!/bin/bash

# Erstelle _template Ordner
mkdir -p "_templates"

# Erstelle Dateien
touch "_templates/datei-1.txt"
touch "_templates/datei-2.pdf"
touch "_templates/datei-3.doc"

# Erstelle _schulklassen Ordner
mkdir -p "_schulklassen"

# Namen
names1=("Anna Müller" "Max Mustermann" "Lisa Schmidt" "Sophia Schneider" 
        "Hans Meier" "Julia Klein" "Elias Becker" "Leonie Braun" 
        "Finn Schwarz" "Emilia Fischer" "Lukas Weber" "Marie Neumann")

names2=("Paul Lorenz" "Sara Hartmann" "Tim Schröder" "Linda Vogel" 
        "Markus Sommer" "Tina Roth" "Oliver Kuhn" "Mia Koch" 
        "Jan Berger" "Laura Richter" "Nico Wolf" "Julia Brandt")

names3=("Tobias Winter" "Emily Jung" "Lukas Beck" "Amelie Meyer" 
        "Moritz Lang" "Charlotte Schmid" "Alexander Hoffmann" "Marie Krämer" 
        "Felix Zimmermann" "Lara Werner" "Simon Schwarz" "Stefanie Maier")

# Funktion
create_class_file() {
    local class_file="$1"
    shift
    local -a names=("$@")
    for name in "${names[@]}"; do
        echo "$name" >> "$class_file"
    done
}

# Schulklassen Daten erstellen
create_class_file "_schulklassen/M122-AP22b.txt" "${names1[@]}"
create_class_file "_schulklassen/M122-AP22c.txt" "${names2[@]}"
create_class_file "_schulklassen/M122-AP22d.txt" "${names3[@]}"
