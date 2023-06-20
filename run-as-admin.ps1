
function Run-Elevated($block) {
    $sh = New-Object -com 'Shell.Application'
    $sh.ShellExecute('powershell',"-NoExit -Command $block",'','runas')
    Exit
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
        
        cd $env:USERPROFILE
        Invoke-WebRequest https://raw.githubusercontent.com/David-Kyrat/lfs-test/test/test2.ps1  -OutFile test.lul
        cd files/res

        ./add_to_path.bat >> ..\..\out.txt
        cd ../..
    }
}

Run-Elevated($block)
Exit
