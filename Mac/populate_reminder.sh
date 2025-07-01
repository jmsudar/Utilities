#!/bin/bash

# Step 1: Trigger helper script, which fills the clipboard
"$@"

# Step 2: Grab from clipboard
template=$(pbpaste)

# Step 3: Replace $1, $2, ... with arguments passed AFTER the script
shift  # Drop the helper script path
arg_index=1

for arg in "$@"; do
  placeholder="\$$arg_index"
  template="${template//$placeholder/$arg}"
  ((arg_index++))
done

# Step 4: Copy result back to clipboard and print
echo "$template" | tee >(pbcopy)
