# yt-plex
This is a script that downloads new YouTube videos from a list of channels you define and saves them in a structure compatible with Plex TV libraries. The only requirements are  and Plex.

The main script only downloads 1 video at a time - the newest one. It's meant to run as a cron job and only grab the newest video. If you want to download all videos from a channel, first run `channel-dl.sh`. 

# Setup
Requires Linux.

Install [yt-dlp](https://github.com/yt-dlp/yt-dlp): `pip install --user yt-dlp` or `sudo apt install yt-dlp`

Clone the repository: `git clone https://github.com/hcnolan/yt-plex.git`

Set your desired download location on **line 6** of the scripts

`urls.txt` contains the links to the YouTube channels you want to download from, one per line. Think of it as a list of your subscriptions. 

**You must run channel-dl.sh first** if you want a copy of the entire channel. `yt-plex.sh` will only download one video per channel at a time.

*Note: `channel-dl.sh` is designed to download one channel at a time, because `yt-dlp` is unstable when downloading a large amount of videos at once. You need to set the channel URL on **line 9** each time you run `channel-dl.sh`. It does not use `urls.txt`.*

Create a new Plex TV library and point it to your download directory. In `Advanced`, set `Agent` to `Personal Media Shows`. Scroll down to `Seasons` and select `Hide for single-season series`. 

Now, add `yt-plex.sh` as a cron job. Run `crontab -e` and append a line like `* * * * * /path/to/repo/yt-dl.sh`. You can use [IT-Tools](https://it-tools.tech/crontab-generator) if you need help.