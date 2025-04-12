#!usr/env/bin bash

# Check that at least two input files and one output are provided
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <input1> <input2> ... <output_file>"
    echo "Example: $0 part1.mp4 part2.mp4 output.mp4"
    exit 1
fi

# Get the last argument as the output file
OUTPUT="${@: -1}"
INPUTS=("${@:1:$#-1}")

# Build input list
INPUT_FLAGS=""
for input in "${INPUTS[@]}"; do
    INPUT_FLAGS="$INPUT_FLAGS -i \"$input\""
done

# Build filter_complex string
FILTER_INPUTS=""
for ((i=0; i<${#INPUTS[@]}; i++)); do
    FILTER_INPUTS+="[${i}:v:0][${i}:a:0]"
done

FILTER="${FILTER_INPUTS}concat=n=${#INPUTS[@]}:v=1:a=1[outv][outa]"

# Eval needed to expand double quotes inside command
eval ffmpeg $INPUT_FLAGS -filter_complex \"$FILTER\" -map \"[outv]\" -map \"[outa]\" \"$OUTPUT\"
