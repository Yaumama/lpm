@echo off

if "%~1" == "" (
    echo Usage: lpm [command] [option]
    exit /b
)

if "%~1" == "help" (
    echo **************************************
    echo *** LPM Commands:                  ***
    echo *** help - This message            ***
    echo *** install [package] - Install a  ***
    echo *** package. Get packages from:    ***
    echo *** https://lpm.yaumama.repl.co/   ***
    echo *** browse - Go to the official    ***
    echo *** website of lpm!                ***
    echo *** -v - check the version of LPM  ***
    echo *** jitrun [lua file] - Runs a lua ***
    echo *** file with luajit.              ***
    echo *** run [lua file] - Runs a lua    ***
    echo *** file with regular lua.         ***
    echo **************************************
    exit /b
)

if "%~1" == "browse" (
    start "" https://lpm.yaumama.repl.co/
    exit /b
)

if "%~1" == "-v" (
    echo LPM version:
    echo 0.5.0
    exit /b
)

if "%~2" == "" (
    echo Usage: lpm [command] [option]
    exit /b
)

if "%~1" == "install" (
    if exist "./%~2.zip" (
        echo You already installed %~2!
        exit /b
    )
    if exist "./%~2" (
        echo You already installed %~2!
        exit /b
    )
    echo Installing...
    powershell -Command "Invoke-WebRequest https://lpm.yaumama.repl.co/%~2/%~2.zip -Outfile %~2.zip"
    echo Done installing!
    echo Extracting...
    powershell -Command "Expand-Archive %~2.zip -DestinationPath ./"
    del "%~2.zip"
    echo Extracted!
    exit /b
)

if "%~1" == "jitrun" (
    if exist "./%~2" (
        /luajit/luajit.exe %~2
        exit /b
    ) else (
        echo %~2 not found!
        exit /b
    )
)

if "%~1" == "run" (
    if exist "./%~2" (
        /lua/lua53.exe %~2
        exit /b
    ) else (
        echo %~2 not found!
        exit /b
    )
)

echo Invalid command!