# escape=^
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8
RUN dotnet tool install --global PowerShell
RUN Invoke-WebRequest -OutFile vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe
RUN Start-Process -Wait -FilePath vs_buildtools.exe -ArgumentList "--quiet --wait --norestart --nocache modify --installPath `"C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools`" --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools --includeOptional"
RUN Remove-Item vs_buildtools.exe
RUN Invoke-WebRequest -OutFile 'dotnet-install.ps1' https://dot.net/v1/dotnet-install.ps1
RUN .\dotnet-install.ps1 -Version '3.1.301'
RUN Remove-Item dotnet-install.ps1
