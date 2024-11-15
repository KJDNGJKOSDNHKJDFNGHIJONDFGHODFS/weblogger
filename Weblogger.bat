@echo off
setlocal

rem Save this code in a text file and save it as a .bat file to execute
rem Dont remember to set your variables!!!!!!!!

:: Set your variables here
set "website_url=https://google.com"
set "log_folder=D:\GoogleHTMLLog"


if not exist "%log_folder%" mkdir "%log_folder%"

:loop
    
    for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format 'yyyyMMdd_HHmmss'"') do set "timestamp=%%i"

    set "log_file=%log_folder%\website_status_%timestamp%.txt"
    
    for /f %%i in ('powershell -NoProfile -Command "try { (Invoke-WebRequest -Uri '%website_url%' -UseBasicParsing).StatusCode } catch { 'DOWN' }"') do set "status=%%i"

    if "%status%"=="DOWN" (
        set "status_message=Website is DOWN"
    ) else (
        set "status_message=Website is UP - Status Code %status%"
    )

    echo [%timestamp%] %status_message% > "%log_file%"

goto loop
