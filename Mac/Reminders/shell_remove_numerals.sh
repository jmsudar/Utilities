echo 'Copied to clipboard:  for f in *.ext; do mv "$f" "${f#[0-9][0-9]*. }"; done'
echo 'prefix=""; for f in "$prefix"*.ext; do mv "$f" "${f#$prefix}"; done' | pbcopy
