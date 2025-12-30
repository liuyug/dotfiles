
setlocal

winget --info

set proxy=socks5://127.0.0.1:1080

winget install ^
BurntSushi.ripgrep.MSVC

winget install ^
--proxy %proxy% ^
BurntSushi.ripgrep.MSVC ^
neovim.neovim ^
equalsraf.neovim-qt ^
Microsoft.Microsoft3DViewer ^
-e
endlocal
