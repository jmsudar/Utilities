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
    
    # Split the video stream only, ignoring audio
    ffmpeg -ss "$start" -to "$end" -i "$INPUT_FILE" -c:v copy -c:a copy "$output"
done < "$TIMESTAMP_FILE"