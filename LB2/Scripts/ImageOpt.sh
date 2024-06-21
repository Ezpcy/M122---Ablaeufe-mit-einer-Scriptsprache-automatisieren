#!/bin/bash

usage() {
    echo "Usage: $0 <image-path>"
    exit 1
}

# Überprüf Parameter
if [ -z "$1" ]; then
    usage
fi

image="$1"

# Überprüfe Pfad
if [ ! -f "$image" ]; then
    echo "Error: File does not exist."
    usage
fi

# Überprüfe Bild
if ! file --mime-type "$image" | grep -q 'image/'; then
    echo "The specified file is not an image."
    exit 2
fi

# API Addresse
api_address="http://api.resmush.it/ws.php"

# Response mit curl
response=$(curl -s -F "files=@$image" -F "qlty=95" "$api_address")

# Überprüfe ob die optimisation erfolgreich war
if [ $? -ne 0 ]; then
    echo "Failed to connect to the image optimization service."
    exit 3
fi

echo "$response"

# Formatier Response mit jq
echo $response | jq .
