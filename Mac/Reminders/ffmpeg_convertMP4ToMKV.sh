echo 'Copied to clipboard: ls *.mp4 | sed 's/\.mp4$//' | xargs -I {} ffmpeg -i "{}.mp4" -c copy "{}.mkv"'
echo 'ls *.mp4 | sed 's/\.mp4$//' | xargs -I {} ffmpeg -i "{}.mp4" -c copy "{}.mkv"' | pbcopy
