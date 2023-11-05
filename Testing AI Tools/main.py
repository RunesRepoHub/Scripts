import os
import time
import subprocess

def download_video(url, output_path):
    try:
        # Check if the video has already been downloaded
        video_file = os.path.join(output_path, f"{url.split('=')[1]}.mp4")
        if os.path.exists(video_file):
            # Check if the video was last accessed more than 1 month ago
            if os.path.getatime(video_file) < time.time() - 30 * 24 * 60 * 60:
                os.remove(video_file)
                print("Video deleted successfully!")
                # Continue with the download
            else:
                print("Video has already been downloaded!")
                return

        # Download video using youtube-dl
        command = f"youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' -o '{output_path}/%(title)s.%(ext)s' {url}"
        subprocess.run(command, shell=True, check=True)

        print("Video downloaded successfully!")
    except Exception as e:
        print(f"Error downloading video: {str(e)}")

