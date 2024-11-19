#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <timestamp_file>"
    exit 1
fi

INPUT_FILE="$1"
TIMESTAMP_FILE="$2"

while IFS= read -r line; do
    start=$(echo "$line" | awk '{print $1}')
    end=$(echo "$line" | awk '{print $2}')
    output=$(echo "$line" | awk '{print $3}')
    
    ffmpeg -i "$INPUT_FILE" -ss "$start" -to "$end" -c copy "$output"
done < "$TIMESTAMP_FILE"
