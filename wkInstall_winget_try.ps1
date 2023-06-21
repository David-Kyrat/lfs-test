# $path =  $MyInvocation.MyCommand.Source
# $path = Resolve-Path "$path/../../.."
# $path = Split-Path "$path" -Parent
#$path = (Get-Item $path).FullName

$op = PWD
where.exe wkhtmltopdf 2>$null | Out-Null
#$wk_exists = $?
if ($wk_exists) { echo "wkhtmltopdf is already installed"; Exit } 

where.exe winget 2>$null | Out-Null
# $winget_exists  = $?
if ( $winget_exists ) {
    winget install --Id wkhtmltopdf.wkhtmltox
    $succ = $?
    if ($succ) { echo "wkhtmltopdf installation will start shortly..."; Exit }
} 

# NOTE: If we cannot download with winget, we have to use a lot less conveniant solution
# i.e. basically make a `$HOME/bin` directory and manually copying the executable to it then add that dir to the PATH env. variable

cd $env:USERPROFILE
mkdir .tmp -ErrorAction SilentlyContinue
cd .tmp

# NB: We have to use a windows batch script because some older machines still runs the legacy version of powershell which removes a LOT of features
Invoke-WebRequest https://raw.githubusercontent.com/David-Kyrat/lfs-test/test/script.bat -OutFile script.bat

# Targeting exactly the the commit where file was added to download the executable and not the git lfs pointer
Invoke-WebRequest "https://github.com/David-Kyrat/Course-Description-Automation/raw/9c7749881598f4d7cbe1b11d1d7a167148b78913/files/res/bin-converters/wkhtmltopdf.exe" -OutFile wkhtmltopdf.exe

ls * -Force

.\script.bat >> "$op/wkpath.txt"
#Run-Elevated

where.exe wkhtmltopdf.exe >> "$op/wkpath.txt"

cd $op
Exit
