#!/bin/bash

# Funktion zum Anzeigen
usage() {
    echo "Usage: $0 -t <target-ip> -p <port-range>"
    echo "Example: $0 -t 192.168.1.200 -p 100-500"
    exit 1
}

# Optionen parsen
while getopts "t:p:" opt; do
  case "$opt" in
    t) target="$OPTARG";;
    p) port_range="$OPTARG";;
    *) usage;;
  esac
done

# Validierung des Targets
if [ -z "$target" ]; then
    usage
fi

# Standard Port range falls nicht angegeben
if [ -z "$port_range" ]; then
    start_port=1
    end_port=65535
else
    IFS='-' read -ra ports <<< "$port_range"
    start_port=${ports[0]}
    end_port=${ports[1]}
fi

# Validierung der Port range
if [ "$start_port" -gt "$end_port" ]; then
    echo "Error: Start port can't be higher than end port."
    exit 2
fi

# FPort überprüfen mit nc
check_ports() {
    for ((port=$start_port; port<=$end_port; port++)); do
        # Timeout auf 1 Sekunde
        nc -z -w1 $target $port &>/dev/null &&
        echo "Port $port is open." &
    done
    wait
}
check_ports
