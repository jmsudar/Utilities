for f in *.mov; do ffmpeg -i "$f" -c copy "${f%.mov}.mkv"; done
