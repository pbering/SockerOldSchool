FROM microsoft/aspnet

ADD *.zip .

RUN powershell -Command \
    Expand-Archive -Path 'C:\dist*.zip' -DestinationPath 'C:\\'; \
    Remove-Item 'C:\dist*.zip' -Force;

RUN powershell -Command \    
    New-Item -Path 'C:\Sitecore\Website' -ItemType Directory -Force ^| Out-Null; \
    Get-ChildItem -Path 'C:\dist*\*' ^| Copy-Item -Destination 'C:\Sitecore\Website' -Recurse -Force; \
    Remove-Item 'C:\dist*' -Recurse -Force; 

ADD Sitecore /Sitecore

RUN powershell -Command \
    Import-Module WebAdministration; \
    Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name 'physicalPath' -Value 'C:\Sitecore\Website'; \
    Set-ItemProperty -Path 'IIS:\apppools\DefaultAppPool' -Name 'enable32BitAppOnWin64' -Value 'False';