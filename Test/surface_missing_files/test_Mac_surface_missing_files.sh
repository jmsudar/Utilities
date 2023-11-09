#!/usr/bin/env bash

# Usage: ./test_surface_missing_files.sh [target_directory]

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Directories for testing
source_directory="source"
comparison_directory="comparison"
# Script path
script_path="../../Mac/surface_missing_files.sh"

# Function to count files in a directory with optional extension filter
count_files() {
  local dir=$1
  local ext=$2
  local count
  if [[ -n $ext ]]; then
    # Count files with the given extension
    count=$(find "$dir" -type f -name "*.$ext" | wc -l)
  else
    # Count all files
    count=$(find "$dir" -type f | wc -l)
  fi
  echo $count | xargs  # Trim whitespace
}

# Helper function to count expected unique files (missing in comparison directory)
count_expected_unique_files() {
  local source_dir=$1
  local comparison_dir=$2
  local extensions=(${3//,/ })
  local unique_count=0

  # Use a case-insensitive match for the file extension
  shopt -s nocaseglob
  for ext in "${extensions[@]}"; do
    local files=($(find "$source_dir" -type f -iname "*.$ext"))
    for file in "${files[@]}"; do
      file=$(basename "$file")
      if [ ! -f "$comparison_dir/$file" ]; then
        ((unique_count++))
      fi
    done
  done
  # Revert to default case sensitivity
  shopt -u nocaseglob

  echo $unique_count
}

# Function to print success or failure message
print_result() {
  local actual=$1
  local expected=$2
  if [[ $actual == $expected ]]; then
    echo -e "${GREEN}SUCCESS: $actual${NC}"
  else
    echo -e "${RED}FAILURE: $actual, but expected $expected.${NC}"
  fi
}

# Test without target directory and no extensions
echo "Test 1: Expecting to list all unique files."
actual_output_1=$($script_path "$source_directory" "$comparison_directory")
echo -e "$actual_output_1"

# Declare expected missing files
expected_missing_files=("Empty2.JPG" "Empty.txt" "Empty3.jpg" "Empty2.gif")

# Check if each expected missing file is in the actual output
all_files_found=true
for file in "${expected_missing_files[@]}"; do
  if ! grep -q "$file" <<< "$actual_output_1"; then
    all_files_found=false
    echo -e "${RED}FAILURE: Missing file $file not listed.${NC}"
  fi
done

if $all_files_found; then
  echo -e "${GREEN}SUCCESS: All expected files are listed as missing.${NC}"
fi

# Test with one extension
expected_count=$(count_expected_unique_files "$source_directory" "$comparison_directory" "jpg")
echo "Test 2: Expecting to list all '.jpg' files that are unique."
actual_output_2=$($script_path "$source_directory" "$comparison_directory" "jpg")
echo -e "$actual_output_2"
actual_count=$(echo "$actual_output_2" | grep -c "Missing file")
print_result "$actual_count" "$expected_count"

# Test with two extensions
expected_count=$(count_expected_unique_files "$source_directory" "$comparison_directory" "jpg,gif")
echo "Test 3: Expecting to list all '.jpg' and '.gif' files that are unique."
actual_output_3=$($script_path "$source_directory" "$comparison_directory" "jpg,gif")
echo -e "$actual_output_3"
actual_count=$(echo "$actual_output_3" | grep -c "Missing file")
print_result "$actual_count" "$expected_count"

# Test with extensions and target directory provided
if [[ -n $1 ]]; then
  target_directory="$1"
  expected_count=$(count_expected_unique_files "$source_directory" "$comparison_directory" "jpg,gif")
  echo "Test 4: Expecting to copy '.jpg' and '.gif' files to the target directory."
  actual_output_4=$($script_path "$source_directory" "$comparison_directory" "$target_directory" "jpg,gif")
  # Count the number of files in the target directory
  echo -e "$actual_output_4"
  actual_count=$(count_files "$target_directory")
  print_result "$actual_count" "$expected_count"
else
  echo -e "${GREEN}Skipping Test 4: No target directory provided.${NC}"
fi
