#!/usr/bin/env bash

# Ensure correct number of arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_file.mp3> <end_timestamp>"
  echo "Example: $0 song.mp3 2:45"
  exit 1
fi

INPUT_FILE="$1"
END_TIME="$2"

# Check if file exists
if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: File '$INPUT_FILE' does not exist."
  exit 1
fi

# Create a temporary output file
TMP_FILE="$(mktemp "${INPUT_FILE%.mp3}.XXXXXX.mp3")"

# Use ffmpeg to trim the file
ffmpeg -y -i "$INPUT_FILE" -to "$END_TIME" -c copy "$TMP_FILE"

# Replace the original file
mv "$TMP_FILE" "$INPUT_FILE"

echo "Trimmed '$INPUT_FILE' to end at $END_TIME."
