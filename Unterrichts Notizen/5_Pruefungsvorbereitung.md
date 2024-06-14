## `ifconfig | grep "Ether" -c`

- Gibt zurück, wie viele Ethernet-Adapter vorhanden sind.

## `tar -vczf backup.tar.gz /root/`

    - Erstellt ein Backup des Ordners /root/ und speichert es in der Datei backup.tar.gz.
    - Optionen:
        - `v`: `verbose` - Gibt Informationen über die Dateien aus, die hinzugefügt werden.
        - `c`: `create` - Erstellt ein neues Archiv.
        - `z`: `gzip` - Komprimiert das Archiv mit gzip.
        - `f`: `file` - Gibt den Dateinamen des Archivs an.

## Wie würde man eine Datei mit folgendem Inhalt erstellen:

```plaintext
Otto
Peter
Martin
Christian
Andrea
Tim
Sven
Heinz
Bob
```

```bash
echo -e "Otto\nPeter\nMartin\nChristian\nAndrea\nTim\nSven\nHeinz\nBob" > namen.txt
```

`-e` ermöglicht die Interpretation von Escape-Sequenzen.

Man kann auch Linie für Linie hinzufügen, dafür muss `>>` verwendet werden um den Inhalt an die Datei anzuhängen.

```bash
echo "Otto" > namen.txt
echo "Peter" >> namen.txt
echo "Martin" >> namen.txt
echo "Christian" >> namen.txt
echo "Andrea" >> namen.txt
echo "Tim" >> namen.txt
echo "Sven" >> namen.txt
echo "Heinz" >> namen.txt
echo "Bob" >> namen.txt
```

## `cat namen.txt | sort -u`

- Gibt den Inhalt der Datei `namen.txt` sortiert und ohne Duplikate aus.
  - `sort`: Sortiert die Eingabe.
    - `-u`: `unique` - Zeigt nur einzigartige Zeilen an.

## Formulieren sie einen Befehl, welcher aus der Datei /etc/passwd alle Heimverzeichnisse ausschneidet und in einer Datei homes.txt speichert.

```bash
cut -d: -f6 /etc/passwd > homes.txt
```

- `cut -d: -f6 /etc/passwd`: Schneidet die sechste Spalte aus der Datei `/etc/passwd` aus.
  - `-d:`: Trennzeichen ist `:`.
  - `-f6`: Gibt die sechste Spalte aus.

## Wie laufen folgende Cronjobs ab?

```bash
*/10 * * * * <befehl1>
5 8 * * 0 <befehl2>
0 10 1 * * <befehl3>
```

- `<befehl1>` wird alle 10 Minuten ausgeführt.
- `<befehl2>` wird jeden Sonntag um 8:05 Uhr ausgeführt.
- `<befehl3>` wird am ersten Tag des Monats um 10:00 Uhr ausgeführt.

## Was macht folgender Befehl?

```bash
     fping -g -c 1 -t250 172.16.6.0/24 2>&1 | grep " 0% " | cut -d " " -f 1
```

- Der Befehl führt einen Ping-Sweep für das Subnetz
  - `-g`: Ping-Sweep.
  - `-c 1`: Führt nur einen Ping durch.
  - `-t250`: Timeout von 250ms.
  - `2>&1`: Leitet stderr nach stdout.
  - `grep " 0% "`: Filtert Zeilen mit 0% Paketverlust.
  - `cut -d " " -f 1`: Extrahiert die IP-Adresse.

## Was macht folgendes Skript?

```bash
#!/bin/bash
for i in $( ifconfig | grep "inet" | grep -v "127.0.0.1" | cut -d ":" -f 2 | cut -d "." -f 1-3 ); do
    #echo $i #Zum Testen entkommentieren
    for k in $(seq 1 255); do
        #echo $k #Zum Testen entkommentieren
        fping -c 1 -t250 $i.$k 2>&1 | grep " 0% " | cut -d " " -f 1 >> ips.txt
    done
done
```

- Das Skript iteriert über alle IP-Adressen im lokalen Netzwerk und prüft, ob sie erreichbar sind. Ping-Sweeper.
  - `ifconfig`: Gibt Informationen über Netzwerkadapter zurück.
  - `grep "inet"`: Filtert Zeilen, die "inet" enthalten.
  - `grep -v`: -v steht für invertiert, d.h. es werden Zeilen ausgeschlossen, die angegeben werden.
  - `cut -d ":" -f 2`: Schneidet die zweite Spalte nach dem Trennzeichen `:` aus. In diesem Fall die IP-Adresse.
  - `cut -d "." -f 1-3`: Schneidet die ersten drei Spalten nach dem Trennzeichen `.` aus. In diesem Fall die ersten drei Oktette der IP-Adresse.

## Was macht folgender Befehl?

```bash
find / -user otto -iname "*bash*" -exec cp {} /data/otto/ \;
```

- Der Befehl sucht nach Dateien, die dem Benutzer `otto` gehören und `bash` im Namen haben. Diese Dateien werden dann in das Verzeichnis `/data/otto/` kopiert.
  - `find /`: Sucht im gesamten Dateisystem.
  - `-user otto`: Filtert Dateien, die dem Benutzer `otto` gehören.
  - `-iname "*bash*"`: Filtert Dateien, die `bash` im Namen haben.
  - `-exec cp {} /data/otto/ \;`: Kopiert die gefundenen Dateien in das Verzeichnis `/data/otto/`. `{}` wird durch den Dateinamen ersetzt.

## Was machen folgende Befehle?

```bash
for ip in $(seq 200 254);do echo 192.168.13.$ip; done > ips.txt
for ip in $(cat ips.txt);do dig -x $ip | grep $ip >> dns.txt; done
```

- Der erste Befehl erstellt eine Liste von IP-Addressen von 200 bis 254 und speichert sie in der Datei `ips.txt` (24er Subnetz).
- Der zweite Befehl iteriert über die IP-Adressen in `ips.txt`, führt einen Reverse-DNS-Lookup durch und speichert die Ergebnisse in der Datei `dns.txt`.

## Übersicht von Befehlen und deren Optionen

- `cut -d: -f6 /etc/passwd > homes.txt`

  - `cut`: Schneidet Text aus einer Datei oder einem Stream.
    - `-d:`: Trennzeichen ist `:`.
    - `-f6`: Gibt die sechste Spalte aus.

- `cat`: Steht für `concatenate`, wird verwendet, um Dateien zu lesen und zu schreiben.

  - Optionen:

  - `cat namen.txt | sort -u`
    - `sort`: Sortiert die Eingabe.
      - `-u`: Zeigt nur einzigartige Zeilen an. Seht für `unique`.
  - Optionen:
    - `-n`: Nummeriert die Ausgabezeilen.
    - `-b`: Ignoriert führende Leerzeichen.
    - `-s`: Unterdrückt mehrfache Leerzeichen.
    - `-T`: Ersetzt Tabulatoren durch Leerzeichen.

- `grep`
  - `grep`: Filtert Zeilen, die einem Muster entsprechen.
    - `-v`: Zeigt Zeilen an, die nicht dem Muster entsprechen. Invertiert die Suche.
    - `-i`: Groß- und Kleinschreibung ignorieren (case-insensitive).
    - `-n`: Zeigt Zeilennummern an.
    - `-r`: Rekursiv, durchsucht auch Unterverzeichnisse.
    - `-l`: Zeigt nur Dateinamen an, in denen das Muster gefunden wurde.
    - `-c`: Zählt die Anzahl der Übereinstimmungen.yd

## If, loops, and conditions

- `(())`: Mathematische Operationen.

  - Wird verwendet, um arithmetische Operationen in Bash auszuführen. z.B.

  ```bash
  echo $((5 + 5))

  if (( 5 > 4 )); then
      echo "5 is greater than 4"
  fi

  for (( i = 0; i < 5; i++ )); do
      echo $i
  done
  ```

- `[[ ]]`: Bedingungen.

  - Wird verwendet, um Bedingungen in Bash zu überprüfen. z.B.

  ```bash
  if [[ "foo" == "foo" ]]; then
      echo "Strings are equal"
  fi

  if [[ 5 -gt 4 ]]; then
      echo "5 is greater than 4"
  fi

  if [[ -f /etc/passwd ]]; then
      echo "/etc/passwd exists"
  fi
  ```

- `[]`: Bedingungen.

  - Wird verwendet, um Bedingungen in Bash zu überprüfen. z.B.

  ```bash
  if [ "foo" = "foo" ]; then
      echo "Strings are equal"
  fi

  if [ 5 -gt 4 ]; then
      echo "5 is greater than 4"
  fi

  if [ -f /etc/passwd ]; then
      echo "/etc/passwd exists"
  fi
  ```

- `(( ))`: Bedingungen.

  - Wird verwendet, um arithmetische Bedingungen in Bash zu überprüfen. z.B.

  ```bash
  if (( 5 > 4 )); then
      echo "5 is greater than 4"
  fi
  ```

- `for i in {1..5}; do echo $i; done`: Schleife.

  - Wird verwendet, um über eine Sequenz von Werten zu iterieren. z.B.

  ```bash
  for i in {1..5}; do
      echo $i
  done
  ```

- `for i in $(seq 1 5); do echo $i; done`: Schleife. - Wird verwendet, um über eine Sequenz von Werten zu iterieren. z.B.
