# Bash Basics

## CLI

### Commands

- The tilde `~` is a shortcut for the home directory.
- The semicolon `;` is used to separate commands.
- The pipe `|`is used to chain commands.
- An hashtag `#` is used to comment out code.
- With a backslash `\` you can escape special characters.
  - You can also use the backslash to continue a command on the next line.
- With an ampersand `&` you can run a command in the background. Example: `sleep 10 &`

### Help

- To get help for a command you can use the `man` command. Example: `man ls`
- `apropos` is used to search for commands. Example: `apropos list`
- `which` is used to find the location of a command. Example: `which ls`

## Some Directory Commands

- With the `find`command you can search for files and directories. Example: `find / -name file.txt`. It's also possbible to use commands on the found file: `find [DIR] -type [f/d] -iname "name" -exec [COMMAND] {} \;`

## File Relevant Commands

- `wc` is used to count words, lines and characters in a file. Example: `wc file.txt`

## Alias

Alias are used as shortcuts for commands. You can create an alias with the `alias` command. Example: `alias ll='ls -l'`. To remove an alias you can use the `unalias` command. Example: `unalias ll`.

## Wildcard and Brace Expansion

- `*` is used to match any character.

```bash
ls *.txt
rm f*.gif
ls *0.*
rm *A*
```

- `?` is used to match any single character.

```bash
ls file?.txt
ls file_??.txt
```

- `{ , }` create files for example.

```bash
touch touch File{1,2,3}.txt
```

- `{..}` is used to create a range of files.

```bash
touch File{1..10}.txt
```

- `!` is used to negate a pattern.

```bash
ls file{!3}.txt
```

- It's also possible to use brace expansion inside other brace expansions.

```bash
touch file{orginal{.bak,.txt},kopie{.bak,.txt}}
```

Will create `fileorginal.bak`, `fileorginal.txt`, `filekopie.bak`, `filekopie.txt`.

## Scripting

A shell script always start with `#!/bin/bash`. After the creation you have to make the script executable with `chmod +x script.sh`.

### Variables

- Variables are used to store data. You can create a variable with `VAR=value`. To access the variable you can use `$VAR`. Example: `VAR=Hello; echo $VAR`. You can make variables read-only with `readonly VAR`.

The retrurn value of a variable can be a command:

```bash
[user@host: ~ ]$ datum=$(date +%Y_%m_%d)
[user@host: ~ ]$ echo $datum
 2022_10_06

[user@host: ~ ]$ touch file_$datum
[user@host: ~ ]$ ls
 file_2022_10_06
[user@host: ~ ]$ datum2=$datum; echo $datum2
 2022_10_06
```

Some important variables are:

- `$LOGNAME` Login-Name des Benutzers
- `$0` Der Name des aufgerufenen Shellscripts
- `$1` - `$9`, `${10}`, ... , `$*` Parameter des aufgerufenen Shellscripts
- `$#` Anzahl Parameter des aufgerufenen Shellscripts
- `$$` Die Prozessnummer des aufgerufenen Shellscripts
- `$?` Der Beendigungsstatus eines Shellscripts
- `$!` Die Prozessnummer des zuletzt gestarteten Hintergrundprozesses
- `$PWD` Aktuelles Arbeitsverzeichnis
- `$OLDPWD` Der Wert ist das zuvor besuchte Arbeitsverzeichnis; wird vom Kommando cd gesetzt.
- `$HOME` Heimverzeichnis für den Benutzer; Standardwert für cd
- `$UID` Die User-ID des Anwenders. Diese Kennung ist in der Datei /etc/passwd dem Benutzernamen zugeordnet.
- `$PATH` Suchpfad für die Kommandos (Programme); meistens handelt es sich um eine durch Doppelpunkte getrennte Liste von Verzeichnissen, in denen nach einem Kommando gesucht wird, das ohne Pfadangabe aufgerufen wurde; Standardwerte: PATH=:/bin:/usr/bin
- `$CDPATH` Suchpfad für das cd-Kommando
- `$SHELL` Zeigt die aktuelle Shell mit dem Pfad an
- `$RANDOM` Pseudo-Zufallszahl zwischen 0 bis 32767
- `$REPLY` Bei Menüs (select) enthält REPLY die ausgewählte Nummer.
- `$SECONDS` Enthält die Anzahl von Sekunden, die seit dem Start (Login) der aktuellen Shell vergangen ist.
- `$PROMPT_COMMAND` Hier kann ein Kommando angegeben werden, das vor jeder Eingabeaufforderung automatisch ausgeführt wird.
- `$PS1` Primärer Prompt; Prompt zur Eingabe von Befehlen.
- `$TZ` Legt die Zeitzone fest (hierzulande MET = Middle European Time)

### Arithmetic Operations

Only integers can be used in arithmetic operations. There are two variants to perform arithmetic operations:

- `var=$((1+2))`
- `var=$[1+2]`
