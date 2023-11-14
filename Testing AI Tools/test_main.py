import pytest
from unittest.mock import Mock, patch, call
import pytube
import os
import time
from main import download_video

@pytest.mark.parametrize(
    "url, output_path, video_title, video_exists, video_access_time, exception_raised, test_id",
    [
        # Happy path tests
        ("https://www.youtube.com/watch?v=dQw4w9WgXcQ", "/videos", "Rick Astley - Never Gonna Give You Up", False, None, None, "happy_path_video_not_exists"),
        ("https://www.youtube.com/watch?v=dQw4w9WgXcQ", "/videos", "Rick Astley - Never Gonna Give You Up", True, time.time() - 31 * 24 * 60 * 60, None, "happy_path_video_exists_old"),
        
        # Edge cases
        ("https://www.youtube.com/watch?v=dQw4w9WgXcQ", "/videos", "Rick Astley - Never Gonna Give You Up", True, time.time() - 29 * 24 * 60 * 60, None, "edge_case_video_exists_recent"),
        
        # Error cases
        ("https://www.youtube.com/watch?v=dQw4w9WgXcQ", "/videos", "Rick Astley - Never Gonna Give You Up", False, None, Exception("Network error"), "error_case_network_error"),
    ]
)
def test_download_video(url, output_path, video_title, video_exists, video_access_time, exception_raised, test_id):
    # Arrange
    with patch.object(pytube, "YouTube", autospec=True) as mock_youtube, \
         patch.object(os, "path", autospec=True) as mock_path, \
         patch.object(os, "system", autospec=True) as mock_system, \
         patch.object(os, "remove", autospec=True) as mock_remove, \
         patch.object(time, "time", autospec=True) as mock_time:
        
        mock_youtube.return_value.streams.get_highest_resolution.return_value.title = video_title
        mock_path.exists.return_value = video_exists
        mock_path.getatime.return_value = video_access_time
        mock_time.return_value = time.time()
        if exception_raised:
            mock_youtube.side_effect = exception_raised

        # Act
        download_video(url, output_path)

        # Assert
        mock_youtube.assert_called_once_with(url)
        mock_path.exists.assert_called_once_with(os.path.join(output_path, f"{video_title}.mp4"))
        if video_exists:
            mock_path.getatime.assert_called_once_with(os.path.join(output_path, f"{video_title}.mp4"))
            if video_access_time < mock_time.return_value - 30 * 24 * 60 * 60:
                mock_remove.assert_called_once_with(os.path.join(output_path, f"{video_title}.mp4"))
        if not exception_raised:
            mock_system.assert_called_once_with(f"docker run -v {output_path}:{output_path} <image_name> python main.py")
