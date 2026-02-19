@echo off
:: Installing Windows 11 25H2 with a Local Account (without a Microsoft Account)
:: https://woshub.com/install-windows-local-user-account/
:: shift+f10
:: start ms-cxh:localonly

:: chrome 查找并连接到本地网络上的任何设备
:: chrome://flags/#local-network-access-check

setlocal

set home=d:\home

if x%1 == xlink (
    echo link   : 做目录链接
    pushd %HOMEPATH%
    mklink /j MyDocs %home%\PersonalDoc\mydocs
    mklink /j Projects %home%\Projects
    mklink /j Scripts %home%\Scripts
    mklink /j .ssh %home%\ssh
    popd
    pushd %HOMEPATH%\Documents
    mklink /j Dictionary %home%\Dictionary
    mklink /j stock_data %home%\股票\stock_build
    popd
) else if x%1 == xinfo (
    systeminfo
) else if x%1 == xssh (
    echo fix ssh key permission for git permission error
    icacls id_ed25519 /inheritance:r
    icacls id_ed25519 /grant:r "%USERNAME%:(F)"
) else if x%1 == xmas (
    echo mas    : 激活
    powershell -Command "irm https://get.activated.win | iex"
) else if x%1 == xmenu (
    echo menu   : 右键显示更多选项
    reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
) else if x%1 == xsmb (
    echo 匿名访问samba
    rem win+R 输入 gpedit.msc 打开组策略如下配置
    rem 本地计算机策略 > 计算机配置 > 管理模板 > 网络 > Lanman 工作站 > 启用不安全的来宾登录 > 已启用
    rem 本地计算机策略 > 计算机配置 > Windows 设置 > 安全设置 > 本地策略 > 安全选项 > Microsoft 网络客户端：对通信进行数字签名（始终）> 已禁用
    powershell -Command "Set-SmbClientConfiguration -RequireSecuritySignature $false"
    powershell -Command "Get-SmbClientConfiguration | FL RequireSecuritySignature"
    powershell -Command "Set-SmbClientConfiguration -EnableInsecureGuestLogons $true"
    powershell -Command "Get-SmbClientConfiguration | Select EnableInsecureGuestLogons"

) else if x%1 == xweb (
    echo 禁用 Web Search in start menu
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /f /d 1
) else if x%1 == xnvim (
    echo 右键用 Nvim-Qt 打开
    reg add "HKEY_CLASSES_ROOT\*\shell\Open with Nvim-Qt" /ve /t REG_SZ /d "用 Nvim-Qt 打开" /f
    reg add "HKEY_CLASSES_ROOT\*\shell\Open with Nvim-Qt"  /v "icon" /t REG_SZ  /d "\"C:\Program Files\neovim-qt 0.2.19\bin\nvim-qt.exe\"" /f
    reg add "HKEY_CLASSES_ROOT\*\shell\Open with Nvim-Qt\command" /ve /t REG_SZ /d "\"C:\Program Files\neovim-qt 0.2.19\bin\nvim-qt.exe\" \"%1\"" /f

) else (
echo info   : System info
echo link   : 做目录链接
echo ssh    : 修复ssh key权限
echo mas    : 激活
echo menu   : 右键显示更多选项
echo smb    : 匿名访问samba
echo web    : 起始菜单禁用web搜索
echo nvim   : 右键用 nvim-qt 打开
)

endlocal
