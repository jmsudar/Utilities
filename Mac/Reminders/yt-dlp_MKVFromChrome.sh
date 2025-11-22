echo 'Copied to clipboard: yt-dlp -f "bv*[vcodec^=avc]+ba[ext=m4a]/b[ext=mp4]/b" --merge-output-format mkv -o "%(title)s.%(ext)s" --cookies-from-browser chrome ""'
echo 'yt-dlp -f "bv*[vcodec^=avc]+ba[ext=m4a]/b[ext=mp4]/b" --merge-output-format mkv -o "%(title)s.%(ext)s" --cookies-from-browser chrome ""' | pbcopy
