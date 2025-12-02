echo 'Copied to clipboard: ext=""; suffix=""; for f in *$ext; do base="${f%$ext}"; mv "$f" "$base$suffix$ext"; done'
echo 'ext=""; suffix=""; for f in *$ext; do base="${f%$ext}"; mv "$f" "$base$suffix$ext"; done' | pbcopy
