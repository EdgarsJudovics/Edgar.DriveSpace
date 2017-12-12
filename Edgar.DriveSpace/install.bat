@echo off

rem credit https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights#11995662
net session >nul 2>&1
    if not %errorLevel% == 0  (
        echo Installation script requres admin privileges
		echo Right click - Run as administrator
        pause
        exit /b
    )

set APP_BASE_DIR=C:\Program Files
set PROJECT=Edgar.DriveSpace
set DLL_BINARY=%PROJECT%.dll

rem -- changes active drive to that where bat file is located
%~d0
rem -- changes active dir to that where bat file is located
cd "%~dp0"
cd "%PROJECT%"
echo -------------------------------
echo ^| Edgar.DriveSpace  installer ^|
echo -------------------------------
echo.

set APP_INSTALL_DIR=%APP_BASE_DIR%\%PROJECT%
echo Enter project installation path:
echo   This is where the app will be installed to
set /p APP_INSTALL_DIR=(ENTER) [default: %APP_INSTALL_DIR%]: 

set COMMAND_NAME=dsize
echo Enter command name:
echo   This will be the command to run from terminal
set /p COMMAND_NAME=(ENTER) [%COMMAND_NAME%]: 

echo  ^> Install path: %APP_INSTALL_DIR%
echo  ^> Command: %COMMAND_NAME%
set CONFIRMATION=n
echo Are you sure you want to install?
set /p CONFIRMATION=(y/n) [default: %CONFIRMATION%]: 

IF NOT %CONFIRMATION%==y  (
	echo Installation cancelled
    exit /b
    )

if not exist "%APP_INSTALL_DIR%" mkdir "%APP_INSTALL_DIR%"
dotnet publish -c Release -o "%APP_INSTALL_DIR%"
if exist "C:\Windows\%COMMAND_NAME%.bat" del "C:\Windows\%COMMAND_NAME%.bat"

@echo @echo off>> "C:\Windows\%COMMAND_NAME%.bat"
@echo dotnet "%APP_INSTALL_DIR%\%DLL_BINARY%">> "C:\Windows\%COMMAND_NAME%.bat"

echo Installation complete
pause