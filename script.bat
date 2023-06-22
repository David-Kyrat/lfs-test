@echo off


REM Define the bin path
set bin_path=%USERPROFILE%\binnn

REM Check if the bin path exists
if not exist "%bin_path%" (
    mkdir "%bin_path%"
)

REM Check if wkhtmltopdf.exe exists in the bin path
if not exist "%bin_path%\wkhtmltopdf.exe" (
    REM Copy wkhtmltopdf.exe to the bin path
    copy "wkhtmltopdf.exe" "%bin_path%"
)

REM backup path in case windows forcefully trims it. (It happens when the path was > 1024 chars long prior to the modification)
echo "%PATH%" > "%USERPROFILE%\PATH-BACKUP-CDA.txt"
REM set path for this session
SET PATH=%bin_path%;%PATH%

REM make change permanent
SETX PATH "%PATH%"

REM if path change was not successful then we are forced to copy the executable somewhere already in path
wkhtmltopdf -V > nul 2>&1 || copy "wkhtmltopdf.exe" "C:\Windows\"



REM if we directly do SETX, change won't affect current session. Plus syntax of setx is harder to use imo. 
REM del .\wkhtmltopdf.exe
Exit
