# $path =  $MyInvocation.MyCommand.Source
# $path = Resolve-Path "$path/../../.."
# $path = Split-Path "$path" -Parent
#$path = (Get-Item $path).FullName


where.exe wkhtmltopdf 2>$null | Out-Null
$wk_exists = $?
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

Invoke-WebRequest https://raw.githubusercontent.com/David-Kyrat/lfs-test/test/script.ps1  -OutFile script.bat

Invoke-WebRequest https://raw.githubusercontent.com/David-Kyrat/lfs-test/test/wkhtmltopdf.exe -OutFile wkhtmltopdf.exe

function Run-Elevated {
    $sh = New-Object -com 'Shell.Application'
    $sh.ShellExecute('powershell',"-NoExit -File .\script.bat",'','runas')
    Exit
}


runas /user:Administrator .\script.bat
#Run-Elevated

Exit

$block = {
    where.exe wkhtmltopdf 2>$null | Out-Null
    $wk_exists = $?
    if ($wk_exists) { Exit }

    # Download dependencies through winget
    where.exe winget 2>$null | Out-Null
    # $winget_exists  = $?
    if ( $winget_exists ) {
        winget install --Id wkhtmltopdf.wkhtmltox
        $succ = $?
        if (-not $succ) { $winget_exists = false }
    } 
    if (-not $winget_exists) {
        #$bin_path = "${env:USERPROFILE}\bin"
        
        cd $env:USERPROFILE
        Invoke-WebRequest https://raw.githubusercontent.com/David-Kyrat/lfs-test/test/test2.ps1  -OutFile test.lul
        cd files/res

        ./add_to_path.bat >> ..\..\out.txt
        cd ../..
    }
}
