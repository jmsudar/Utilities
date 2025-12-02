echo 'Copied to clipboard: ext=""; prefix=""; for f in "$prefix"*$ext; do mv "$f" "${f#$prefix}"; done'
echo 'ext=""; prefix=""; for f in "$prefix"*$ext; do mv "$f" "${f#$prefix}"; done' | pbcopy
