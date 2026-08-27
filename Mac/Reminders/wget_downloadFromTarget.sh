#!/bin/zsh
set -e

if (( $# != 1 )); then
  print -u2 "Usage: ${0:t} IDENTIFIER"
  exit 1
fi

identifier=$1
url="https://archive.org/services/loans/loan/?action=media_url&identifier=${identifier}&format=pdf&redirect=1"
cookie_file=$(mktemp -t archive_cookies)
trap 'rm -f -- "$cookie_file"' EXIT

yt-dlp --cookies-from-browser chrome \
       --cookies "$cookie_file" \
       --skip-download \
       "https://archive.org" 2>/dev/null || true

wget --load-cookies "$cookie_file" \
     --user-agent="Mozilla/5.0" \
     -O "${identifier}.acsm" \
     "$url"
