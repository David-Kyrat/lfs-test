@echo off

REM Define the bin path
set bin_path=%USERPROFILE%\binnn

REM Check if the bin path exists
if not exist "%bin_path%" (
    mkdir "%bin_path%" > nul 2>&1
)

REM Check if wkhtmltopdf.exe exists in the bin path
if not exist "%bin_path%\wkhtmltopdf.exe" (
    REM Copy wkhtmltopdf.exe to the bin path
    copy "wkhtmltopdf.exe" "%bin_path%"
)
del .\wkhtmltopdf.exe

REM set path for this session
SET PATH=%PATH%;%USERPROFILE%\bin

REM make change permanent

SETX PATH "%PATH%"

where.exe wkhtmltopdf

Exit

REM if we directly do SETX, change won't affect current session. Plus syntax of setx is harder to use imo. 
