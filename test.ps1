# $path =  $MyInvocation.MyCommand.Source
# $path = Resolve-Path "$path/../../.."
# $path = Split-Path "$path" -Parent
$path = (Get-Item $path).FullName

function Run-Elevated ($scriptblock) {
    $sh = New-Object -com 'Shell.Application'
    $sh.ShellExecute('powershell',"-NoExit $scriptblock",'','runas')
    exit
}

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
        
        cd files/res

        ./add_to_path.bat >> ..\..\out.txt
        cd ../..
    }
}

Run-Elevated ($block)
