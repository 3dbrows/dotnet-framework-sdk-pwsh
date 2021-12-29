# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8

# Install pwsh, VS BuildTools 2019 with F#, WiX, .NET Core 3.1.301, AWS CLI.
RUN dotnet tool install --global PowerShell ; `
    Invoke-WebRequest -OutFile AWSCLIV2.msi https://awscli.amazonaws.com/AWSCLIV2.msi ; `
    Invoke-WebRequest -OutFile dotnet-install.ps1 https://dot.net/v1/dotnet-install.ps1 ; `
    Invoke-WebRequest -OutFile wix314.exe https://wixtoolset.org/downloads/v3.14.0.5722/wix314.exe ; `
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) ; `
    choco feature enable -n allowGlobalConfirmation ; `
    choco install visualstudio2019-workload-manageddesktopbuildtools --package-parameters '--includeRecommended --add Microsoft.VisualStudio.Component.FSharp.MSBuild' ; `
    Start-Process wix314.exe -Wait -ArgumentList '/install /quiet /norestart' ; `
    .\dotnet-install.ps1 -Version '3.1.301' -InstallDir 'C:\Program Files\dotnet' -SkipNonVersionedFiles ; `
    Start-Process msiexec.exe -Wait -ArgumentList '/i AWSCLIV2.msi /quiet' ; `
    setx /M PATH $('C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\dotnet\;C:\Users\ContainerAdministrator\AppData\Local\Microsoft\WindowsApps;C:\Users\ContainerAdministrator\.dotnet\tools;C:\Program Files\NuGet;C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools;C:\Program Files (x86)\Microsoft SDKs\ClickOnce\SignTool;C:\Program Files\Amazon\AWSCLIV2') ; `
    Remove-Item dotnet-install.ps1 ; `
    Remove-Item AWSCLIV2.msi ; `
    Remove-Item wix314.exe
