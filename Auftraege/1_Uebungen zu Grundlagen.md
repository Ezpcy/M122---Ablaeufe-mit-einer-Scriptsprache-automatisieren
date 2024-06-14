# Übungen zu den Grundlagen

## Übung 1 - Repetition: Navigieren in Verzeichnissen

1. Wechseln Sie mit cd in Ihr Heimverzeichnis.

```bash
cd ~
```

2. Wechseln Sie ins Verzeichnis /var/log mit einer absoluten Pfadangabe

```bash
cd /var/log
```

3. Wechseln Sie ins Verzeichnis /etc/udev mit einer absoluten Pfadangabe

```bash
cd /etc/udev
```

4. Wechseln Sie ins Verzeichnis /etc/ mit einer relativen Pfadangabe

```bash
cd ../etc
```

5. Wechseln Sie ins Verzeichnis /etc/network/ mit einer relativen Pfadangabe

```bash
cd network
```

6. Wechseln Sie ins Verzeichnis /dev/ mit einer relativen Pfadangabe

```bash
cd ../../dev
```

## Übung 2 - Wildcards

Lösen Sie folgende Übungen der Reihe nach (Verwenden Sie soviele Wildcards und/oder Braces wie nur irgendwie möglich! ):

1. Erzeugen Sie ein Verzeichnis Docs in ihrem Heimverzeichnis

```bash
mkdir ~/Docs
```

2. Erstellen Sie die Dateien file1 bis file10 mit touch im Docs-Verzeichnis

```bash
touch ~/Docs/file{1..10}
```

3. Löschen Sie alle Dateien, welche einer 1 im Dateinamen haben

```bash
rm ~/Docs/*1*
```

4. Löschen Sie file2, file4, file7 mit einem Befehl

```bash
rm ~/Docs/file{2,4,7}
```

5. Löschen Sie alle restlichen Dateien auf einmal

```bash
rm ~/Docs/*
```

6. Erzeugen Sie ein Verzeichnis Ordner in ihrem Heimverzeichnis

```bash
mkdir ~/Ordner
```

7. Erstellen Sie die Dateien file1 bis file10 mit touch im Ordner-Verzeichnis

```bash
touch ~/Ordner/file{1..10}
```

8. Kopieren Sie das Verzeichnis Ordner mitsamt Inhalt nach Ordner2

```bash
cp -r ~/Ordner ~/Ordner2
```

9. Kopieren Sie das Verzeichnis Ordner mitsamt Inhalt nach Ordner2/Ordner3

```bash
cp -r ~/Ordner ~/Ordner2/Ordner3
```

10. Benennen Sie das Verzeichnis Ordner in Ordner1 um

```bash
mv ~/Ordner ~/Ordner1
```

11. Löschen Sie alle erstellten Verzeichnisse und Dateien wieder

```bash
rm -r ~/Ordner1 ~/Ordner2
```

## Übung 3 - Tilde expansions

Führen Sie jede in der Theorie aufgeführte Erweiterungen der Tilde ~ einmal an Ihrem System aus und stellen Sie sicher, dass Sie deren Funktionsweisen verstanden haben.

```bash
cd ~ # Home directory
cd ~- # Previous directory
cd ~+ # Current directory
cd ~user # Home directory of user
```

## Übung 4 - grep, cut (, awk):

a) Erzeugen Sie eine Textdatei mit folgendem Inhalt:

```txt
alpha1:1alpha1:alp1ha
beta2:2beta:be2ta
gamma3:3gamma:gam3ma
obelix:belixo:xobeli
asterix:sterixa:xasteri
idefix:defixi:ixidef
```

Durchsuchen Sie die Datei mit grep nach folgenden Mustern (benutzen Sie die
Option --color=auto):

- Alle Zeilen, welche obelix enthalten

  ```bash
  grep --color=auto obelix datei.txt
  ```

- Alle Zeilen, welche 2 enthalten

  ```bash
  grep --color=auto 2 datei.txt
  ```

- Alle Zeilen, welche ein e enthalten

  ```bash
  grep --color=auto e datei.txt
  ```

- Alle Zeilen, welche nicht gamma enthalten

  ```bash
  grep --color=auto -v gamma datei.txt # v steht für invert
  ```

- Alle Zeilen, welche 1, 2 oder 3 enthalten (benutzen Sie -E und eine regex)

  ```bash
  grep --color=auto -E '1|2|3' datei.txt # E steht für extended regex
  ```

b) Gehen Sie von derselben Datei aus wie in Übung a). Benutzen Sie cut und
formulieren Sie damit einen Befehl, um nur folgende Begriffe anzuzeigen:

- Alle Begriffe vor dem ersten :-Zeichen

  ```bash
  cut -d: -f1 datei.txt # d steht für delimiter, f steht für field
  ```

- Alle Begriffe zwischen den beiden :-Zeichen

  ```bash
  cut -d: -f2 datei.txt
  ```

- Alle Begriffe rechts des letzten :-Zeichen

  ```bash
  cut -d: -f3 datei.txt
  ```

c) Nur für Knobbler: Gehen Sie wieder von derselben Datei aus wie in Übung a). Benutzen Sie awk und
formulieren Sie damit einen Befehl, um nur die Begriffe anzuzeigen, die sich zwischen dem letzten und dem zweitletzten :-Zeichen befinden. Sie kriegen das gleiche Resultat wie bei der zweiten Übung unter b), aber nun dynamisch und die Anzahl Separatoren spielt keine Rolle mehr.

```bash
awk -F: '{print $(NF-1)}' datei.txt # F steht für field separator, NF ist die Anzahl der Felder
```

> **awk**: Awk ist eine Programmiersprache, die für die Verarbeitung von Textdateien entwickelt wurde. Sie ist besonders gut geeignet, um Daten in Tabellenform zu verarbeiten. Awk ist eine sehr mächtige Sprache, die es ermöglicht, komplexe Aufgaben mit wenigen Zeilen Code zu lösen.

## Übung 5 - Für Fortgeschrittene

- Was macht folgender Ausdruck? `mesg | egrep '[0-9]{4}:[0-9]{2}:[0-9a-f]{2}.[0-9]`

  - Zeigt alle Zeilen an, die ein Zeitstempel enthalten

- Was macht folgender Ausdruck? `ifconfig | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])`
  - Zeigt alle IP-Adressen an
  - `-o` zeigt nur den Treffer an
  - `-E` steht für extended regex

## Übung 6 - stdout, stdin, stderr

a) Erzeugen Sie eine Textdatei mit folgendem Inhalt:

```txt
a
b
c
d
e
```

Benutzen Sie zur Erzeugung `<<` indem Sie Zeile fur Zeile an `cat` übergeben, die
Ausgabe wird in eine Datei umgeleitet. Benutzen Sie das Schlusswort `END`.

```bash
cat << END > datei.txt
a
b
c
d
e
END
```

- **<<**: Wird benutzt um eine Eingabe zu simulieren. Der Text nach dem << wird als Eingabe interpretiert.
- Hier wird der Text `a b c d e` in die Datei `datei.txt` geschrieben.

**b)** Die Ausführung von `ls -z` erzeugt einen Fehler (da es die Option `-z` nicht gibt).
Starten Sie ls mit -z und leiten Sie die Fehler in eine Datei `/root/errorsLs.log` um.

```bash
ls -z 2> /root/errorsLs.log
```

**c)** Erzeugen Sie eine kl. Textdatei und füllen Sie diese mit Inhalt. Geben Sie die
Textdatei mit `cat` aus und leiten Sie die Ausgabe wieder in eine neue Datei um.
Benutzen Sie einmal `>` und einmal `>>` (mehrmals hintereinander). Untersuchen Sie
die beiden Situationen, indem Sie jedesmal den Inhalt der Datei wieder ausgeben.
Was passiert wenn Sie in dieselbe Datei umleiten wollen?

```bash
echo "Hallo Welt" > datei.txt
cat datei.txt > datei2.txt
cat datei.txt >> datei2.txt
cat datei2.txt
```

- _>_: Überschreibt die Datei
- _>>_: Hängt an die Datei an

**d)** Leiten Sie die Ausgabe von `whoami` in die Datei `info.txt` um

```bash
whoami > info.txt
```

**e)** Hängen Sie die Ausgabe von `id` an die Datei `info.txt` an

```bash
id >> info.txt
```

**f)** Leiten Sie die Datei `info.txt` als Eingabe an das Programm `wc` um und zählen
Sie damit die Wörter (`-w`)

```bash
wc -w < info.txt
```
