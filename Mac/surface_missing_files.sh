#!/usr/bin/env bash

# Directories
source_directory="$1"
comparison_directory="$2"
target_directory="$3"

# Create the target directory if it doesn't exist
mkdir -p "$target_directory"

# Extensions to check (case-insensitive, without a dot, comma-separated)
IFS=',' read -r -a extensions <<< "$4"

# Function to check if an array contains a specific value
containsElement () {
  local e match=$(echo "$1" | tr '[:upper:]' '[:lower:]') # Convert to lowercase
  shift
  for e; do
    if [[ $(echo "$e" | tr '[:upper:]' '[:lower:]') == "$match" ]]; then
      return 0
    fi
  done
  return 1
}

# Find files in the source directory and compare them with the comparison directory
# If they do not exist in the comparison directory and meet the extension criteria, copy them to the target directory
# Exclude .DS_Store files from being copied and make extension check case-insensitive
find "$source_directory" -type f -print0 | while IFS= read -r -d $'\0' file; do
  filename=$(basename -- "$file")
  # Skip .DS_Store files
  if [[ "$filename" == ".DS_Store" ]]; then
    continue
  fi
  # Check file extension against provided list, if applicable
  if [ ${#extensions[@]} -ne 0 ]; then
    extension="${filename##*.}"
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]') # Convert to lowercase with tr
    containsElement "$extension" "${extensions[@]}" || continue
  fi
  # Check if file does not exist in the comparison directory
  if [ ! -f "$comparison_directory/$filename" ]; then
    echo "Copying missing file: $filename"
    cp "$file" "$target_directory"
  fi
done

echo "Operation completed."
