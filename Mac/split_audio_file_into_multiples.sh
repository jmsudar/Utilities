#!/bin/bash

INPUT_FILE="input.mp3"
TIMESTAMP_FILE="timestamps.txt"

while IFS= read -r line; do
    start=$(echo "$line" | awk '{print $1}')
    end=$(echo "$line" | awk '{print $2}')
    output=$(echo "$line" | awk '{print $3}')
    
    ffmpeg -i "$INPUT_FILE" -ss "$start" -to "$end" -c copy "$output"
done < "$TIMESTAMP_FILE"
