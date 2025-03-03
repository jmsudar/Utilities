echo 'Copied to clipboard: ls *.mkv | sed 's/\.mkv$//' | xargs -I {} ffmpeg -i "{}.mkv" -c copy "{}.mp4"'
echo 'ls *.mkv | sed 's/\.mkv$//' | xargs -I {} ffmpeg -i "{}.mkv" -c copy "{}.mp4"' | pbcopy