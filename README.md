# Edgar.DriveSpace
A terminal program for Windows/Linux that shows partitions and used/total space as well as a bar to represent said space.  
That is all it does, there are no command line arguments or other parameters.  
Written in C# and runs on .NET Core  

# Screenshots
Linux terminal through SSH  
![Linux Terminal](./Screenshots/linux_terminal.png)

Windows terminal  
![Windows Terminal](./Screenshots/win_terminal.png)

# Requirements
* .NET Core 2.0 or higher installed on the machine to compile the source.  
To see if it's installed execute `dotnet --version` in terminal/console.
* Admin privileges

# Installation
## Short version
Run the install script based on your OS (either .bat or .sh)  
Follow instructions  

## Longer - Linux
```
git clone https://github.com/EJLV/Edgar.DriveSpace.git
cd Edgar.DriveSpace
sudo ./install.sh
```
Follow the instructions  
By default the files are installed into `/opt/Edgar.DriveSpace/` and shell script is available at `/usr/bin/dsize`  
Call the program by typing `dsize` in terminal  

## Longer - Windows
Run cmd/powershell/cmder... as administrator
```
git clone https://github.com/EJLV/Edgar.DriveSpace.git
cd Edgar.DriveSpace
```
if using cmd
```
install.bat
```
or PowerShell
```
./install.bat
```
(just run install.bat as admin one way or the other)
Follow instructions
By default the files are installed into `C:\Program Files\Edgar.DriveSpace\` and batch file `C:\Windows\dsize.bat`  
Call the program by typing dsize in terminal

## OS X
Should work but hasn't been tested
