echo 'Copied to clipboard: yt-dlp -f "bv*[vcodec^=avc]+ba[ext=m4a]/b[ext=mp4]/b" --cookies-from-browser chrome -o "%(title)s.%(ext)s" "$1"'
echo 'yt-dlp -f "bv*[vcodec^=avc]+ba[ext=m4a]/b[ext=mp4]/b" --cookies-from-browser chrome -o "%(title)s.%(ext)s" "$1"' | pbcopy
