#!/bin/bash

# Script to download a YouTube playlist as MP3 files and add ID3 metadata
# Usage: ./download_playlist_and_set_metadata.sh <URL> <artist> <genre> <album> <num_tracks> [start_track_num]

# Check if correct number of parameters provided
if [ "$#" -lt 6 ] || [ "$#" -gt 7 ]; then
    echo "Error: Incorrect number of parameters"
    echo "Usage: $0 <URL> <artist> <genre> <album> <year> <num_tracks> [start_track_num]"
    echo ""
    echo "Parameters:"
    echo "  URL              - YouTube playlist URL"
    echo "  artist           - Artist name for metadata"
    echo "  genre            - Genre for metadata"
    echo "  album            - Album name for metadata"
    echo "  year             - Album release year for metadata"
    echo "  num_tracks       - Total track count for metadata (e.g., 38 for a 38-track album)"
    echo "  start_track_num  - (Optional) Starting track number (defaults to 1)"
    echo ""
    echo "Examples:"
    echo "  # Download playlist as tracks 1-10"
    echo "  $0 'https://youtube.com/playlist?list=...' 'Artist Name' 'Rock' 'Album Name' 10"
    echo ""
    echo "  # Download playlist as tracks 18-38 (continuing an existing album)"
    echo "  $0 'https://youtube.com/playlist?list=...' 'Artist Name' 'Rock' 'Album Name' 38 18"
    exit 1
fi

# Assign parameters to readable variable names
URL="$1"
ARTIST="$2"
GENRE="$3"
ALBUM="$4"
YEAR="$5"
NUM_TRACKS="$6"
START_TRACK_NUM="${7:-1}"  # Default to 1 if not provided

# Validate num_tracks is a number
if ! [[ "$NUM_TRACKS" =~ ^[0-9]+$ ]]; then
    echo "Error: num_tracks must be a positive number"
    exit 1
fi

# Validate start_track_num is a number
if ! [[ "$START_TRACK_NUM" =~ ^[0-9]+$ ]]; then
    echo "Error: start_track_num must be a positive number"
    exit 1
fi

echo "========================================="
echo "Downloading playlist and setting metadata"
echo "========================================="
echo "URL: $URL"
echo "Artist: $ARTIST"
echo "Genre: $GENRE"
echo "Album: $ALBUM"
echo "Year: $YEAR"
echo "Total Tracks: $NUM_TRACKS"
echo "Starting Track Number: $START_TRACK_NUM"
echo "========================================="
echo ""

# Step 1: Get list of video URLs from playlist
echo "Step 1: Getting playlist information..."
playlist_urls=$(yt-dlp --flat-playlist --get-id "$URL" | awk -v url="https://www.youtube.com/watch?v=" '{print url $0}')

if [ -z "$playlist_urls" ]; then
    echo "Error: Could not retrieve playlist information"
    exit 1
fi

# Count number of videos
video_count=$(echo "$playlist_urls" | wc -l | tr -d ' ')
echo "Found $video_count videos in playlist"
echo ""

# Step 2: Download and tag each video individually
track_num=$START_TRACK_NUM
successful_downloads=0
while IFS= read -r video_url; do
    
    echo "========================================="
    echo "Processing track $track_num/$NUM_TRACKS"
    echo "URL: $video_url"
    echo "========================================="
    
    # Download this specific video as MP3
    echo "Downloading..."
    yt-dlp -x --audio-format mp3 --cookies-from-browser chrome -o "temp_download.mp3" "$video_url"
    
    if [ $? -ne 0 ]; then
        echo "✗ Error: Download failed for track $track_num"
        echo "Retrying with different format..."
        # Try again without audio extraction issues
        yt-dlp -x --audio-format mp3 --cookies-from-browser chrome --no-continue -o "temp_download.mp3" "$video_url"
        
        if [ $? -ne 0 ]; then
            echo "✗ Error: Retry failed for track $track_num, skipping..."
            echo ""
            ((track_num++))
            continue
        fi
    fi
    
    # Check if file actually exists
    if [ ! -f "temp_download.mp3" ]; then
        echo "✗ Error: Downloaded file not found for track $track_num"
        echo ""
        ((track_num++))
        continue
    fi
    
    # Get the actual title from yt-dlp for the final filename
    video_title=$(yt-dlp --get-title --cookies-from-browser chrome "$video_url")
    # Sanitize filename (remove/replace problematic characters)
    safe_title=$(echo "$video_title" | sed 's/[\/\\:*?"<>|]/-/g')
    final_filename="${safe_title}.mp3"
    
    # Rename temp file to actual title
    mv "temp_download.mp3" "$final_filename"
    
    echo "✓ Downloaded: $final_filename"
    
    # Apply metadata
    echo "Applying metadata..."
    id3v2 --artist "$ARTIST" --genre "$GENRE" --album "$ALBUM" --year "$YEAR" --track "$track_num/$NUM_TRACKS" "$final_filename"
    
    if [ $? -eq 0 ]; then
        echo "✓ Metadata applied successfully"
        ((successful_downloads++))
    else
        echo "✗ Warning: Failed to apply metadata"
    fi
    
    echo ""
    ((track_num++))
done <<< "$playlist_urls"

echo "========================================="
echo "Process complete!"
echo "Successfully downloaded and tagged $successful_downloads files"
echo "========================================="
