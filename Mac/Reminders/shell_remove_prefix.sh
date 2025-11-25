echo 'Copied to clipboard: prefix=""; for f in "$prefix"*.ext; do mv "$f" "${f#$prefix}"; done'
echo 'prefix=""; for f in "$prefix"*.ext; do mv "$f" "${f#$prefix}"; done' | pbcopy
