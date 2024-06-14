# chmod

## Rechte

- `r` - Lesen
- `w` - Schreiben
- `x` - Ausführen

**Beispiele:**

- `rwx` - Lesen, Schreiben, Ausführen
- `rw-` - Lesen, Schreiben
- `r-x` - Lesen, Ausführen. `-` bedeutet, dass das Recht nicht gesetzt ist.

## Rechtevergabe

- `u` - User
- `g` - Gruppe
- `o` - Andere
- `a` - Alle

**Beispiele:**

- `u+x` - User darf ausführen
- `g-w` - Gruppe darf nicht schreiben
- `o-r` - Andere dürfen nicht lesen

**Durch Zahlen:**

- `r` - 4
- `w` - 2
- `x` - 1

**Beispiel:**

- `rwx` - 7
- `rw-` - 6
- `r-x` - 5

**Befehlsaufbau:**

- `chmod 750 datei` - User darf alles, Gruppe darf lesen und ausführen, Andere dürfen nichts
- `chmod 2770 datei` - User darf alles, Gruppe darf lesen und schreiben, Andere dürfen nichts. Hierbei wird das Sticky-Bit gesetzt, dass nur der Besitzer Dateien löschen kann.

## Rechte anzeigen

```bash
ls -l
```

**Ausgabe:**

```bash
- drwxr-xr-x 2 root root 4096 Jan  1 00:00 test
```

- `d` - Verzeichnis
- `rwx` - Rechte des Besitzers
- `r-x` - Rechte der Gruppe
- `r-x` - Rechte der Anderen
- `2` - Anzahl der Dateien im Verzeichnis
- `root` - Besitzer
- `root` - Gruppe
- `4096` - Größe
- `Jan  1 00:00` - Datum

## Befehle

- `chmod` - Ändert die Rechte einer Datei
- `chown` - Ändert den Besitzer einer Datei
- `chgrp` - Ändert die Gruppe einer Datei

**Syntax:**

```bash
chmod <Optionen> <Rechte> <Datei>
```

**Optionen:**

- `-R` - Rekursiv
- `-v` - Zeigt Änderungen an
- `-c` - Zeigt nur geänderte Dateien an

**Sonderrrechte:**

- `s` - Set-UID-Bit, Datei wird mit den Rechten des Besitzers ausgeführt
- `t` - Sticky-Bit, nur der Besitzer kann Dateien löschen
- `x` - Execute-Bit, wenn das Execute-Bit gesetzt ist, wird das Sticky-Bit angezeigt

- `drwxrws--T` - Set-UID-Bit, Set-GID-Bit, Sticky-Bit

Um diese Rechte zu setzen, wird folgender Befehl verwendet:

```bash
chmod 2770 datei
```

Um das T zu setzen, wird folgender Befehl verwendet:

```bash
chmod 1777 datei
```
