#!/bin/bash
# This is a script that uses yt-dlp (https://github.com/yt-dlp/yt-dlp) to download youtube videos to channels that you subscribe to.
# Add it to your crontab and it'll automatically download new videos as they come out. 

# CHANGE THIS TO YOUR DESIRED DOWNLOAD LOCATION
video_dir=videos/

# Read channels to download from
urls="urls.txt"
readarray -t urls < <(cat "$urls" | tr -d '\r')

for url in "${urls[@]}"
do
        channel_name="${url##*@}"
        channel_name="${channel_name%%/*}"
        #echo "$channel_name"
        channel_path="${video_dir%/}/$channel_name"

        # Check if directory exists
        if [ ! -d "$channel_path" ]; then
            mkdir -p "$channel_path"

            # Download profile photo
            yt-dlp -P "$channel_path" "$url" --write-thumbnail --playlist-items 0
            # Rename photo
            profile_photo=$(ls "${video_dir%/}/$channel_name")
            profile_path="$channel_path/$profile_photo"
            mv "$profile_path" "$channel_path/show.jpg"
            
            # Create video archive file to store most recent video ID
            yt-dlp -I1 -s --force-write-archive --download-archive "$channel_path"/archive.txt "$url"
            
            # Create season folder
            mkdir "$channel_path/Season 1"
            
            # Download the most recent video 
            yt-dlp -f mp4 -P "$channel_path/Season 1" -o "S01E01 - %(title)s.%(ext)s" --embed-thumbnail --embed-metadata --playlist-end 1 -i -w "$url"
        else
            # Get count of existing mp4 files for episode number
            count=$(ls "$channel_path" | grep ".mp4$" | wc | awk '{ print $1 }')
            ((count++))
            if [ "$count" -lt 10 ]; then
                episode_number="S01E0$count"
            else
                episode_number="S01E$count"
            fi
            
            yt-dlp -P "$channel_path/Season 1" -o "$episode_number - %(title)s.%(ext)s" -S ext:mp4:m4a --break-on-existing --download-archive "$channel_path"/archive.txt --playlist-reverse --playlist-end 1 --embed-thumbnail --embed-metadata -i -w "$url"
        fi
done

