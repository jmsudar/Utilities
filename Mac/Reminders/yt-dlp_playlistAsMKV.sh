echo 'Copied to clipboard: yt-dlp -f "bestvideo+bestaudio/best" --merge-output-format mkv --cookies-from-browser chrome -o "%(title)s.%(ext)s" "$1"'
echo 'yt-dlp -f "bestvideo+bestaudio/best" --merge-output-format mkv --cookies-from-browser chrome -o "%(title)s.%(ext)s" "$1"' | pbcopy
