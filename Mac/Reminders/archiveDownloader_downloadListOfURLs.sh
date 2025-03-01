echo 'Copied to clipboard: cat urls.txt | xargs -I {} python archive-org-downloader.py -e "$INTERNET_ARCHIVE_EMAIL" -p "$INTERNET_ARCHIVE_PASS" -d ~/Downloads -u "{}"'
echo 'cat urls.txt | xargs -I {} python archive-org-downloader.py -e "$INTERNET_ARCHIVE_EMAIL" -p "$INTERNET_ARCHIVE_PASS" -d ~/Downloads -u "{}"' | pbcopy
