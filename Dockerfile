# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8

# Install pwsh, .NET Core 3.1.301, AWS CLI, WiX.
RUN dotnet tool install --global PowerShell ; `
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) ; `
    choco feature enable -n allowGlobalConfirmation ; `
    choco install dotnetcore-sdk --version=3.1.301 ; `
    choco install awscli ; `
    Invoke-WebRequest -OutFile wix314.exe https://wixtoolset.org/downloads/v3.14.0.5722/wix314.exe ; `
    Start-Process wix314.exe -Wait -ArgumentList '/install /quiet /norestart' ; `
    Remove-Item wix314.exe
