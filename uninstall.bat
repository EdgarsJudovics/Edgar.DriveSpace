@echo off

rem credit https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights#11995662
net session >nul 2>&1
    if not %errorLevel% == 0  (
        echo Uninstallation script requres admin privileges
		echo Right click - Run as administrator
        pause
        exit /b
    )

set APP_BASE_DIR=C:\Program Files
set PROJECT=Edgar.DriveSpace
set DLL_BINARY=%PROJECT%.dll

cd "%PROJECT%"
echo Started uninstalling %PROJECT%

set APP_INSTALL_DIR=%APP_BASE_DIR%\%PROJECT%
echo Enter project installation path:
set /p APP_INSTALL_DIR=(ENTER) [default: %APP_INSTALL_DIR%]: 

set COMMAND_NAME=dsize
echo Enter command name:
set /p COMMAND_NAME=(ENTER) [default: %COMMAND_NAME%]: 

set CONFIRMATION=n
echo Are you sure you want to uninstall?
set /p CONFIRMATION=(y/n) [default: %CONFIRMATION%]: 

IF NOT %CONFIRMATION%==y  (
	echo Uninstall cancelled
    exit /b
    )

if exist "%APP_INSTALL_DIR%" rmdir /s /q "%APP_INSTALL_DIR%"
if exist "C:\Windows\%COMMAND_NAME%.bat" del "C:\Windows\%COMMAND_NAME%.bat"

echo Uninstall complete
pause