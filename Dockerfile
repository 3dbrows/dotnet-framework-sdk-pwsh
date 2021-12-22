# escape=`
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8

# Install pwsh
RUN dotnet tool install --global PowerShell

# Remove VS2022, install 2019 with F#. Laziness: reuse 2022 dir to save editing PATH.
RUN Invoke-WebRequest -OutFile vs_buildtools.exe https://aka.ms/vs/16/release/vs_buildtools.exe ; `
    Start-Process -Wait -FilePath vs_buildtools.exe -ArgumentList '--quiet uninstall --installPath "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"' ; `
    Start-Process -Wait -FilePath vs_buildtools.exe -ArgumentList '--quiet --wait --norestart --nocache --installPath "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools" --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools --add Microsoft.VisualStudio.Workload.DataBuildTools --includeRecommended --includeOptional'; `
    Remove-Item vs_buildtools.exe

# Install .NET Core 3.1.301
RUN Invoke-WebRequest -OutFile 'dotnet-install.ps1' https://dot.net/v1/dotnet-install.ps1 ; `
    .\dotnet-install.ps1 -Version '3.1.301' -InstallDir 'C:\Program Files\dotnet' -SkipNonVersionedFiles ; `
    Remove-Item dotnet-install.ps1
