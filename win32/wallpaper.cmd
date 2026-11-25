@echo off

setlocal

For /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set mydate=%%a-%%b-%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)

set target_dir="%HOMEPATH%\Pictures\wallpaper"
rem mkdir %target_dir%"

:: 当前桌面背景图片
set wallpaper="%AppData%\Microsoft\Windows\Themes\TranscodedWallpaper"
xcopy /y /-i /f %wallpaper% "%target_dir%\wallpaper_%mydate%_%mytime%.jpg"

:: Windows 聚焦（Spotlight）锁屏图片
set spotlight="%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"

for %%i in ("%spotlight%\*") do (
    rem echo %%~nxi
    xcopy /y /-i /f "%%i" "%target_dir%\spotlight_%%~nxi.jpg"
)
