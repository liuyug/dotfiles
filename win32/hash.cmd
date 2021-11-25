@echo off

setlocal

if "x%2" == "x" (
    rem certutil -hashfile -?
    echo Usage:
    echo hash.cmd ^<filename^> ^<md2^|md4^|md5^|sha1^|sha256^|sha384^|sha512^>
    exit /b 1
)

certutil -hashfile %1 %2

endlocal
