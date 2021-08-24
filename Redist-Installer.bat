@echo off

:: Redist Installer
:: Permalink: https://github.com/ChxseH/Redist-Installer/releases/download/latest/Redist-Installer.bat
:: Version: 7/23/2021 9:41 PM
:: Written by Chase (https://chse.dev)


:: Run as Admin
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

title Redist Installer
echo Redist Installer
echo Written by Chase (https://chse.dev)
echo This file will close when done, restart your computer after to be sure everything installed correctly.
echo.

:: Make a temp place to store all the redists.
md %temp%\Redist-Installer >nul 2>&1
cd %temp%\Redist-Installer
:: Create & Whitelist Plutonium, and X Labs folders.
md "%localappdata%\Plutonium" >nul 2>&1
md "%localappdata%\Plutonium-staging" >nul 2>&1
md "%localappdata%\xlabs" >nul 2>&1
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%localappdata%\Plutonium"
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%localappdata%\Plutonium-staging"
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%localappdata%\xlabs"

:: Start the downloading...
echo [1] Downloading Redists (This may take a while...)
echo Downloading 1/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://aka.ms/vs/16/release/vc_redist.x86.exe', 'vcredist2015_2017_2019_x86.exe')"
echo Downloading 2/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://aka.ms/vs/16/release/vc_redist.x64.exe', 'vcredist2015_2017_2019_x64.exe')"
echo Downloading 3/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://aka.ms/highdpimfc2013x64enu', '2013_x64.exe')"
echo Downloading 4/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://aka.ms/highdpimfc2013x86enu', '2013_x86.exe')"
echo Downloading 5/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe', '2012_x64.exe')"
echo Downloading 6/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe', '2012_x86.exe')"
echo Downloading 7/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe', '2010_x86.exe')"
echo Downloading 8/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/3/2/2/3224B87F-CFA0-4E70-BDA3-3DE650EFEBA5/vcredist_x64.exe', '2010_x64.exe')"
:: 2008 has been pulled from M$'s website multiple times in the past, using a copy hosted on Discord just in case they nuke it again.
echo Downloading 9/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/710609237805498500/839636091417919488/2008_x86.exe', '2008_x86.exe')"
echo Downloading 10/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/710609237805498500/839636081263640586/2008_x64.exe', '2008_x64.exe')"
:: DirectX has been pulled from M$'s website multiple times in the past, using a copy hosted on Discord just in case they nuke it again.
echo Downloading 11/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/710609237805498500/804707669428535366/dxwebsetup.exe', 'DirectX.exe')"
echo Downloading 12/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/710609237805498500/785666488219992084/DX90c_Addon_Installer.exe', 'DirectXA.exe')"
echo Downloading 13/13...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://go.microsoft.com/fwlink/?LinkId=863262', 'dotNET.exe')"

:: Start the installing...
echo [2] Installing Redists (This may take a while...)
echo Installing 1/13...
vcredist2015_2017_2019_x86.exe /install /quiet /norestart
echo Installing 2/13...
vcredist2015_2017_2019_x64.exe /install /quiet /norestart
echo Installing 3/13...
2013_x86.exe /install /quiet /norestart
echo Installing 4/13...
2013_x64.exe /install /quiet /norestart
echo Installing 5/13...
2012_x86.exe /install /quiet /norestart
echo Installing 6/13...
2012_x64.exe /install /quiet /norestart
echo Installing 7/13...
2010_x86.exe /install /quiet /norestart
echo Installing 8/13...
2010_x64.exe /install /quiet /norestart
echo Installing 9/13...
2008_x86.exe /install /quiet /norestart
echo Installing 10/13...
2008_x64.exe /install /quiet /norestart
echo Installing 11/13...
start /wait DirectX.exe /Q
echo Installing 12/13...
start /wait DirectXA.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-
echo Installing 13/13...
start /wait dotNET.exe /Q

:: Cleanup...
echo [3] Cleaning up...
cd %temp%
rmdir %temp%\Redist-Installer /s /q
echo.
echo Done! If there are any errors, please create an issue on GitHub:
echo https://github.com/ChxseH/Redist-Installer/issues/new/
echo.
echo Press any key to close.
pause>nul
exit
