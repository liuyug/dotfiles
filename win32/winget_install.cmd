echo off

setlocal

winget --info

set proxy=socks5://127.0.0.1:1080
rem set upgrade=-e
set upgrade=
 
set Microsoft.Microsoft3DViewer=9NBLGGH42THS
set "apps=BurntSushi.ripgrep.MSVC Neovim.Neovim equalsraf.neovim-qt %Microsoft.Microsoft3DViewer% UniversalCtags.Ctags"


for %%a in (%apps%) do (
    echo == %%a ==
    winget install --proxy %proxy% %upgrade% --id=%%a
)


endlocal
