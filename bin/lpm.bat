@echo off

if "%~1" == "" (
    echo [91mUsage: lpm [command] [option][0m
    exit /b
)

if "%~1" == "help" (
    echo [32m**************************************
    echo *** LPM Commands:                  ***
    echo ***--------------------------------***
    echo *** help - This message            ***
    echo ***--------------------------------***
    echo *** install [package] - Install a  ***
    echo *** package. Get packages from:    ***
    echo *** https://lpm.yaumama.repl.co/   ***
    echo ***--------------------------------***
    echo *** uninstall [package] - Uninstall***
    echo *** a package.                     ***
    echo ***--------------------------------***
    echo *** update [package] - Update a    ***
    echo *** package.                       ***
    echo ***--------------------------------***
    echo *** browse - Go to the official    ***
    echo *** website of lpm!                ***
    echo ***--------------------------------***
    echo *** -v - check the version of LPM  ***
    echo ***--------------------------------***
    echo *** jitrun [lua file] - Runs a lua ***
    echo *** file with luajit.              ***
    echo ***--------------------------------***
    echo *** run [lua file] - Runs a lua    ***
    echo *** file with regular lua.         ***
    echo ***--------------------------------***
    echo *** init - Generates a lpm.lpm file***
    echo **************************************[0m
    exit /b
)

if "%~1" == "browse" (
    start "" https://lpm.yaumama.repl.co/
    exit /b
)

if "%~1" == "-v" (
    echo LPM version:
    echo 0.5.3
    exit /b
)

if "%~1" == "init" (
    if exist lpm.lpm (
        echo [91mlpm.lpm already exists![0m
    ) else (
        echo ./main.lua>./lpm.lpm
        echo [92mCreated lpm.lpm with main file as "main.lua"![0m
    )
    
    if exist main.lua (
        echo [91mmain.lua laready exists![0m
    ) else (
        echo -- Code here>./main.lua
        echo [92mCreated main.lua![0m
    )
    exit /b
)

if "%~2" == "" (
    if "%~1" == "jitrun" (
        if exist "./lpm.lpm" (
            for /F %%i in (lpm.lpm) do (
                if exist %%i (
                    %~dp0../luajit/luajit.exe %%i
                ) else (
                    echo [91m%%i not found![0m
                )
                exit /b
            )
        )
    )

    if "%~1" == "run" (
        if exist "./lpm.lpm" (
            for /F %%i in (lpm.lpm) do (
                if exist %%i (
                    %~dp0../lua/lua54.exe %%i
                ) else (
                    echo [91m%%i not found![0m
                )
                exit /b
            )
        )
    )
)

if "%~2" == "" (
    echo [91mUsage: lpm [command] [option][0m
    exit /b
)

if "%~1" == "install" (
    for /f %%A in ('curl -sLk https://lpm.yaumama.repl.co/packages/%~2/%~2.zip --write-out "%%{http_code}" -o nul') do (
        if "%%A"=="200" (
            if exist "./%~2.zip" (
                echo [91mYou already installed %~2![0m
                exit /b
            )
            if exist "./%~2" (
                echo [91mYou already installed %~2![0m
                exit /b
            )
            echo [33mInstalling...[0m
            powershell -Command "Invoke-WebRequest https://lpm.yaumama.repl.co/packages/%~2/%~2.zip -Outfile %~2.zip"
            echo.
            echo [92mDone installing![0m
            echo [33mExtracting...[0m
            powershell -Command "Expand-Archive %~2.zip -DestinationPath ./"
            del "%~2.zip"
            echo.
            echo [92mExtracted![0m
            echo.
            echo.
            echo [92mSuccessfully installed %~2![0m
        ) else (
            echo [91mPackage %~2 doesn't exist.[0m
        )
    )
    exit /b
)

if "%~1" == "uninstall" (
    for /f %%A in ('curl -sLk https://lpm.yaumama.repl.co/%~2/%~2.zip --write-out "%%{http_code}" -o nul') do (
        if "%%A"=="200" (
            if exist "./%~2" (
                echo [33mDeleting...[0m
                rd /S /Q %~2
                echo.
                echo [92mDeleted![0m
                echo.
                echo.
                echo [92mSuccessfully uninstalled %~2![0m
            ) else (
                echo [91mYou don't have %~2 installed![0m
            )
        ) else (
            echo [91mPackage %~2 doesn't exist.[0m
        )
    )
    exit /b
)

if "%~1" == "update" (
    for /f %%A in ('curl -sLk https://lpm.yaumama.repl.co/packages/%~2/%~2.zip --write-out "%%{http_code}" -o nul') do (
        if "%%A"=="200" (
            if exist "./%~2" (
                echo [33mDeleting old version...
                rd /S /Q %~2
                echo.
                echo [92mDeleted![0m
                echo [33mReinstalling...[0m
                powershell -Command "Invoke-WebRequest https://lpm.yaumama.repl.co/packages/%~2/%~2.zip -Outfile %~2.zip"
                echo.
                echo [92mDone reinstalling![0m
                echo [33mExtracting...[0m
                powershell -Command "Expand-Archive %~2.zip -DestinationPath ./"
                del "%~2.zip"
                echo.
                echo [92mExtracted![0m
                echo.
                echo.
                echo [92mSuccessfully updated %~2![0m
            ) else (
                echo [91mYou don't have %~2 installed![0m
            )
        ) else (
            echo [91mPackage %~2 doesn't exist.[0m
        )
    )
    exit /b
)

if "%~1" == "jitrun" (
    if exist "./%~2" (
        %~dp0../luajit/luajit.exe %~2
        exit /b
    ) else (
        echo [91m%~2 not found![0m
        exit /b
    )
)

if "%~1" == "run" (
    if exist "./%~2" (
        %~dp0../lua/lua54.exe %~2
        exit /b
    ) else (
        echo [91m%~2 not found![0m
        exit /b
    )
)

echo Invalid command!
