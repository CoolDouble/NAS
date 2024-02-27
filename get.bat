@echo off

mkdir %USERPROFILE%\Desktop\Steam
cd /D %USERPROFILE%\Desktop\Steam
break>install.ps1
echo $ProgressPreference = "SilentlyContinue" >> install.ps1
echo $ErrorActionPreference = "Stop" >> install.ps1
echo [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 >> install.ps1
echo $steamURL = "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe" >> install.ps1
echo $sevenURL = "https://github.com/CoolDouble/NAS/raw/main/7z.exe" >> install.ps1
echo $rand = Get-Random -Maximum 99999999 >> install.ps1
echo $Folder = [Environment]::GetFolderPath("Desktop") + "\Steam" >> install.ps1
echo New-Item -ItemType Directory -Force -Path $Folder >> install.ps1
echo Set-Location -Path $Folder >> install.ps1
echo $SteamExtractPath = "temp$rand" >> install.ps1

echo $steamResponse = Invoke-WebRequest -Uri $steamURL -outfile "SteamSetup.exe" >> install.ps1
echo $sevenResponse = Invoke-WebRequest -Uri $sevenURL -outfile "7z.exe" >> install.ps1

echo $sevenArgs = "x SteamSetup.exe -o$SteamExtractPath" >> install.ps1
echo Start-Process 7z.exe $sevenArgs -Wait >> install.ps1
echo Remove-Item 7z.exe -Force >> install.ps1
echo Remove-Item SteamSetup.exe -Force >> install.ps1
echo Move-Item -Path "$SteamExtractPath\*" -Destination $Folder -Force >> install.ps1
echo Remove-Item $SteamExtractPath -Force >> install.ps1
echo Start-Sleep -Seconds 3 >> install.ps1
@powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
del %USERPROFILE%\Desktop\Steam\install.ps1
start %USERPROFILE%\Desktop\Steam\steam.exe