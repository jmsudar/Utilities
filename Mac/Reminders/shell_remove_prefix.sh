echo 'Copied to clipboard: prefix=""; for f in "$prefix"*.mp3; do mv "$f" "${f#$prefix}"; done'
echo 'prefix=""; for f in "$prefix"*.mp3; do mv "$f" "${f#$prefix}"; done' | pbcopy
