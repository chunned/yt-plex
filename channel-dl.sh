#!/bin/bash
# Downloads an entire channel in episode/season format
# Should be run BEFORE plextube.sh 

# CHANGE THIS TO YOUR DESIRED DOWNLOAD LOCATION
video_dir=videos/

# ENTER CHANNEL URL HERE 
channel_url=https://www.youtube.com/@chunned7264/


channel_name="${channel_url##*@}"
channel_name="${channel_name%%/*}"
channel_path="${video_dir%}/$channel_name"
mkdir -p "$channel_path"

# Download profile photo
yt-dlp -P "$channel_path" "$channel_url" --write-thumbnail --playlist-items 0
# Rename photo
profile_photo=$(ls "${video_dir%/}/$channel_name")
profile_path="$channel_path/$profile_photo"
mv "$profile_path" "$channel_path/show.jpg"

mkdir "$channel_path/Season 1"
yt-dlp -f mp4 -P "$channel_path" -o "s01e%(autonumber)02d - %(title)s.%(ext)s" --download-archive "$channel_path"/archive.txt --playlist-reverse --embed-thumbnail --embed-metadata -i -w "$channel_url"