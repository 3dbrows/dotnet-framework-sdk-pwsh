# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8

# Install pwsh, VS BuildTools 2019 with F#, .NET Core 3.1.301, fake-cli, AWS CLI.
RUN dotnet tool install --global PowerShell ; `
    dotnet tool install fake-cli --tool-path 'C:\fake' --version 5.20.4 ; `
    Invoke-WebRequest -OutFile vs_buildtools.exe https://aka.ms/vs/16/release/vs_buildtools.exe ; `
    Invoke-WebRequest -Outfile AWSCLIV2.msi https://awscli.amazonaws.com/AWSCLIV2.msi ; `
    Invoke-WebRequest -OutFile dotnet-install.ps1 https://dot.net/v1/dotnet-install.ps1 ; `
    $env:args = '--quiet --wait --norestart --nocache --installPath C:\BuildTools2019 --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools --includeRecommended --includeOptional' ; `
    echo $env:args ; `
    echo Start-Process -Wait -FilePath vs_buildtools.exe -ArgumentList \"$env:args\" ; `
    Start-Process -Wait -FilePath vs_buildtools.exe -ArgumentList \"$env:args\" ; `
    ls ; `
    .\dotnet-install.ps1 -Version '3.1.301' -InstallDir 'C:\Program Files\dotnet' -SkipNonVersionedFiles ; `
    Start-Process msiexec.exe -Wait -ArgumentList '/i AWSCLIV2.msi /quiet' ; `
    setx /M PATH $('C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\dotnet\;C:\Users\ContainerAdministrator\AppData\Local\Microsoft\WindowsApps;C:\Users\ContainerAdministrator\.dotnet\tools;C:\Program Files\NuGet;C:\BuildTools2019\MSBuild\Current\Bin;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools;C:\Program Files (x86)\Microsoft SDKs\ClickOnce\SignTool;C:\Program Files\Amazon\AWSCLIV2') ; `
    Remove-Item vs_buildtools.exe ; `
    Remove-Item dotnet-install.ps1 ; `
    Remove-Item AWSCLIV2.msi
