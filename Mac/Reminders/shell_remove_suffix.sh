echo 'Copied to clipboard: ext=""; suffix=""; for f in *$ext; do base="${f%$ext}"; newbase="${base%$suffix}"; mv "$f" "$newbase$ext"; done'
echo 'ext=""; suffix=""; for f in *$ext; do base="${f%$ext}"; newbase="${base%$suffix}"; mv "$f" "$newbase$ext"; done' | pbcopy
