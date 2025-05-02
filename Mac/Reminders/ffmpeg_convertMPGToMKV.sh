echo 'Copied to clipboard: ls *.mpg | sed '\''s/\.mpg$//'\'' | xargs -I {} ffmpeg -i "{}.mpg" -c:v libx264 -c:a aac "{}.mkv"'
echo 'ls *.mpg | sed '\''s/\.mpg$//'\'' | xargs -I {} ffmpeg -i "{}.mpg" -c:v libx264 -c:a aac "{}.mkv"' | pbcopy

