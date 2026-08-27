#!/bin/zsh
set -e

if (( $# != 1 )); then
  print -u2 "Usage: ${0:t} IDENTIFIER"
  exit 1
fi

identifier=$1
url="https://archive.org/services/loans/loan/?action=media_url&identifier=${identifier}&format=pdf&redirect=1"

wget -O "${identifier}.acsm" "$url"
