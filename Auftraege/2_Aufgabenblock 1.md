# Aufgebenblock 1

1. Erzeugt Benutzer anhand einer Liste von Benutzernamen in einer Textdatei (via Parameter angegebenen).
   Hinweis: Benutzen Sie useradd und cat.

```bash
#!/bin/bash

# Überprüfen, ob ein Dateiname als Parameter übergeben wurde
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Dateiname aus dem Parameter lesen
FILENAME=$1

# Überprüfen, ob die Datei existiert
if [ ! -f "$FILENAME" ]; then
    echo "File not found: $FILENAME"
    exit 1
fi

# Jede Zeile in der Datei lesen und als Benutzername verwenden
while IFS= read -r username; do
    # Benutzer hinzufügen, Fehler behandeln
    if ! useradd "$username"; then
        echo "Failed to add user $username"
    else
        echo "User added: $username"
    fi
done < "$FILENAME"
```

**Alternative Lösung:**

```bash
#!/bin/bash

#In aufg1.sh gespeichert!
for user in $(cat $1); do
    useradd $user;
done
```

2. Fügt einen Benutzer anhand einer Liste von Gruppen in einer Textdatei (via Parameter angegebenen) den jeweiligen Gruppen hinzu. Hinweis: Benutzen Sie groupadd , usermod und cat. Achtung es gibt für jeden Benutzer jeweils eine Initial login group und mehrere Supplementary groups.

```bash
#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILENAME=$1

# Check if the specified file exists
if [ ! -f "$FILENAME" ]; then
    echo "File not found: $FILENAME"
    exit 1
fi

# Read each line from the file
while IFS= read -r line; do
    # Extract the username and groups from the line
    username=$(cut -d':' -f1 <<< "$line")
    groups=$(cut -d':' -f2 <<< "$line")

    # Determine the initial and supplementary groups
    initial_group=$(cut -d',' -f1 <<< "$groups")
    supplementary_groups=$(cut -d',' -f2- <<< "$groups")

    # Create the initial group if it does not exist
    if ! getent group "$initial_group" &> /dev/null; then
        groupadd "$initial_group"
    fi

    # Add user with the initial group
    useradd -g "$initial_group" "$username"

    # Add user to supplementary groups if specified
    if [ -n "$supplementary_groups" ]; then
        usermod -a -G "$supplementary_groups" "$username"
    fi
done < "$FILENAME"

```

**Alternative Lösung:**

```bash
#!/bin/bash
for group in $(cat $1); do
    groupadd -f $group | usermod -a -G $group $2 #$2 ist username
done
```

3. Findet alle Dateien, welche einem (via Parameter angegebenen) Benutzer gehören und kopiert diese an den aktuellen Ort. Die kopierten Dateien werden zu einem `tar.gz` Archiv zusammengefasst und danach gelöscht. Die Archivdatei wird mit dem Benutzernamen und dem aktuellen Datum benannt. Hinweis: Benutzen Sie `find`, `tar`, `rm` und `date`.

```bash
#!/bin/bash

if ["$#" -ne 1]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1

# Find all files owned by the specified user
find / -user "$USERNAME" -exec cp -t . {} +
# -exec: Execute the following command
# cp -t . {}: Copy the found files to the current directory
# +: Copy multiple files at once

# Create a tar.gz archive with the copied files
tar -czf "$USERNAME-$(date +%Y-%m-%d).tar.gz" *
# -c: Create a new archive
# -z: Compress the archive with gzip
# -f: Specify the archive file name

# Remove the copied files
rm -f *
# -f: Force removal without confirmation
```

**Alternative Lösung:**

```bash
#!/bin/bash
name=$1_$(date '+%y-%m-%d').tar.gz;
find /home/user/* -user $1 -exec cp {} /home/user/Docs/found/ \;
tar -zcvf /home/user/Docs/found/$name /home/user/Docs/found/;
find /home/user/Docs/found/ -type f ! -name $name -delete;
```

- `tar` Optionen
  - `z`:

4. Ermittelt die eigene IP-Adresse und macht einen PING-Sweep für das Subnetz der eigenen IP. Gibt aus, welche Hosts up sind und speichert die IP-Adressen der Hosts in einer Textdatei. Hinweis: Benutzen Sie `ping` (oder `fping`), `ifconfig` und `grep`.

```bash
#!/bin/bash
# cut -d ":" -f 2: Trennt die Zeile anhand des Doppelpunkts und gibt das zweite Feld zurück
# cut -d "." -f 1-3: Trennt die Zeile anhand des Punkts und gibt die Felder 1 bis 3 zurück
for i in $( ifconfig | grep "inet" | grep -v "127.0.0.1" | cut -d ":" -f 2 | cut -d "." -f 1-3 ); do
    for k in $(seq 1 255); do
        fping -c 1 -t250 $i.$k 2>&1 |  grep " 0% " | cut -d " " -f 1 >ips.txt
    done
done

#alternative Lösung:
fping -g -c 1 -t250 172.16.6.0/24 2>&1 | grep " 0% " | cut -d " " -f 1 ips.txt
# -g: Ping sweep
# -c 1: Send only one ping packet
# -t250: Timeout of 250 ms
# 2>&1: Redirect stderr to stdout
# grep " 0% ": Filter lines with 0% packet loss
# cut -d " " -f 1: Extract the IP address
```

5. Erstellen Sie einen Ordner `/root/trash` und erzeugen Sie einige Dateien darin. Erstellen Sie ein Skript, welches alle 5 Minuten die Dateien innerhalb von diesem Ordner löscht (für Infos siehe auch Link 3 im Anhang). Überprüfen Sie, ob ihr Skript korrekt eingerichtet ist, indem Sie nachsehen, ob die Files nach 5 Minuten gelöscht wurden.

```shell
[root@host: ~]# [sudo] mkdir /root/trash
[root@host: ~]# [sudo] touch /root/trash/file{1..10}
[root@host: ~]# [sudo] nano /root/trash.sh


    #!/bin/bash
    rm /root/trash/*


[root@host: ]# [sudo] chmod +x trash.sh
[root@host: ]# [sudo] crontab -e

    */5 * * * * /root/trash.sh

[root@host: ]# watch ls /root/trash
# watch ls: Wiederholt ls alle 2 Sekunden

(Warten bis files verschwinden --erfolgreiche Ausführung)
```

6. Erstellen Sie ein Skript, mit welchem eine IP-Adressrange _bannen_ oder _unbannen_ können. Es gibt unterschiedliche Tools, womit Sie diese Funktionalität umsetzen können. Verwenden Sie das Internet zur Informationssuche.

```bash
#!/bin/bash
if [ $2 -eq "ban" ]; then
    echo "banning " $1
    iptables -A INPUT -s $1 -j DROP
    # -A: Append a rule to the chain
    # -s: Source IP address
    # -j: Jump to the target DROP
    # DROP: Drop the packet
elif [ $2 -eq "unban" ];then
    echo "unbanning " $1
    iptables -D INPUT -s $1 DROP
    # -D: Delete a rule from the chain
else
    echo "Verwendung:"
    echo "1.Arg: IP-Adresse"
    echo "2.Arg.: ban oder unban"
    echo "Beispiel: ./ban.sh 192.168.13.3 ban"
fi
```
