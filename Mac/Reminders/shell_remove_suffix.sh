echo 'Copied to clipboard: suffix=""; for f in *.ext; do base="${f%$suffix.ext}"; mv "$f" "$base.ext"; done'
echo 'suffix=""; for f in *.ext; do base="${f%$suffix.ext}"; mv "$f" "$base.ext"; done' | pbcopy
