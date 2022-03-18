在VLC播放OneDrive中的内容
**依赖于[onedrive-vercel-index](https://github.com/spencerwooo/onedrive-vercel-index)**

需要从 http://regex.info/code/JSON.lua as VLC/lua/modules/JSON.lua 下载 JSON.lua 

并放置于 vlc/lua/modules/JSON.lua
    C:\Program Files\VideoLAN\VLC\lua\modules\ on Windows;
    VLC.app/Contents/MacOS/share/lua/modules/ on Mac OS X;
    /usr/share/vlc/lua/modules/ or ~/.local/share/vlc/lua/modules/ on Linux.

下载项目中的 onedrive-index.lua
并放置于 vlc/lua/playlist/
    C:\Program Files\VideoLAN\VLC\lua\playlist\ on Windows;
    VLC.app/Contents/MacOS/share/lua/playlist/ on Mac OS X;
    /usr/share/vlc/lua/playlist/ or ~/.local/share/vlc/lua/playlist/ on Linux.