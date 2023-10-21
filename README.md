# Plextube
This is a script that downloads new YouTube videos from a list of channels you define and saves them in a structure compatible with Plex TV libraries. 

`urls.txt` contains the links to the YouTube channels you want to download from, one per line. Think of it as a list of your subscriptions. 

The main script only downloads 1 video at a time - the newest one. It's meant to run as a cron job and only grab the newest video. If you want to download all videos from a channel, first run `channel-dl.sh`. 

You should change **line 6** of each script to set the desired download location.

*Note: `channel-dl.sh` is designed to download one channel at a time, because `yt-dlp` is unstable when downloading a large amount of videos at once. You need to set the channel URL on **line 9** each time you run `channel-dl.sh`.*

Create a new Plex library with the TV format and point it to your download directory. Each channel will show up as a show with a single season, and the episodes will be in chronological order. 
