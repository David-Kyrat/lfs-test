# $path =  $MyInvocation.MyCommand.Source
# $path = Resolve-Path "$path/../../.."
# $path = Split-Path "$path" -Parent
#$path = (Get-Item $path).FullName


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

# If we cannot download with winget, we have to use a lot less conveniant solution

cd $env:USERPROFILE
mkdir .tmp -ErrorAction SilentlyContinue
cd .tmp


Invoke-WebRequest https://raw.githubusercontent.com/David-Kyrat/lfs-test/test/script.bat -OutFile script.bat

# Targeting exactly the the commit where file was added to download the executable and not the git lfs pointer
Invoke-WebRequest "https://github.com/David-Kyrat/lfs-test/raw/e84dc9d025de1883a956977c7e01cc66cae3cde2/wkhtmltopdf.exe" -OutFile wkhtmltopdf.exe

ls * -Force

#runas /user:Administrator .\script.bat
.\script.bat
#Run-Elevated

Exit

