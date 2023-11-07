#!/usr/bin/env bash

# Check minimum number of arguments
if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <source_directory> <comparison_directory> [target_directory/extensions]"
  exit 1
fi

# Directories
source_directory="$1"
comparison_directory="$2"
# Initialize target_directory and extensions
target_directory=""
extensions=()

# Determine if the third argument is a target directory or extension list
if [[ $# -ge 3 ]]; then
  if [[ "$3" == *\/* ]] || [[ -d "$3" ]]; then
    target_directory="$3"
    # Create the target directory if it doesn't exist
    [[ ! -d "$target_directory" ]] && mkdir -p "$target_directory"
  else
    IFS=',' read -r -a extensions <<< "$3"
  fi
fi

# Check if the optional fourth argument for extensions is present
if [[ $# -eq 4 ]]; then
  IFS=',' read -r -a extensions <<< "$4"
fi

# Function to check if an array contains a specific value (case insensitive)
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
# If they do not exist in the comparison directory and meet the extension criteria, optionally copy them to the target directory
# Exclude .DS_Store files from being copied and make extension check case-insensitive
find "$source_directory" -type f -print0 | while IFS= read -r -d $'\0' file; do
  filename=$(basename -- "$file")
  # Skip .DS_Store files
  if [[ "$filename" == ".DS_Store" ]]; then
    continue
  fi
  # Check file extension against provided list, if applicable
  extension=$(echo "${filename##*.}" | tr '[:upper:]' '[:lower:]') # Convert to lowercase with tr
  if [[ ${#extensions[@]} -ne 0 ]]; then
    containsElement "$extension" "${extensions[@]}" || continue
  fi
  # Check if file does not exist in the comparison directory
  if [ ! -f "$comparison_directory/$filename" ]; then
    echo "Missing file: $filename"
    # Copy the file if target directory is provided
    if [[ ! -z $target_directory ]]; then
      echo "Copying..."
      cp "$file" "$target_directory"
    fi
  fi
done

echo "Operation completed."

