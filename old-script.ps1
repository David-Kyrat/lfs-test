cd $env:USERPROFILE
cd .tmp


$bin_path = "${env:USERPROFILE}\bin"
if (-not (Test-Path "$bin_path")) { mkdir "$bin_path" } 
if (-not (Test-Path "$bin_path\wkhtmltopdf.exe")) {
    cp wkhtmltopdf.exe "$bin_path"
}

cmd.exe /C 'SET PATH=%PATH%;%USERPROFILE%\bin && SETX PATH "%PATH%"'
