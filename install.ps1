#
# install.ps1
#

$Name = 'PsLogHandler'
$Author = 'SteloNLD'

$CurrentPath = $PSCommandPath | Split-Path
$ConfiguredModulePaths = $env:PSModulePath -split ";" -match $env:USERNAME
$tmpdir = Join-Path -Path $env:TEMP -ChildPath ($Name + '-' + (Get-Random))

# 1 Install
# 2 Update
$InstallMode = 1
$InstallPath = $null

#$SourceCred = Get-Credential -UserName $Author -Message 'SourcePath Credentials'
$SourceCred = $null 
$SourcePath = "https://github.com/$Author/$Name/archive/master.zip"

$InstalationsFound = 0
foreach ($ModulePath in $ConfiguredModulePaths) {
    $Path = Join-Path -Path $Path -ChildPath $Name
    if (Test-Path $Path) {
        $InstalationsFound++
        if ($Path -eq $CurrentPath) {
            $InstallMode = 2
            $InstallPath = $Path
            Break
        }
    }
    $InstallPath = $Path
}

if ($InstalationsFound -gt 1) {
    Write-Error -Message "$Name has been installed at $i locations, execution aborted."    
    exit 
}

Else {
    new-item -ItemType Directory -Path $tmpdir
    $InstallZip =  Join-Path -Path $tmpdir -ChildPath 'install.zip'

    if ($Cred -ne $null) {
        Invoke-WebRequest -Uri $SourcePath -OutFile $InstallZip -Credential $SourceCred
    } 

    else {
        Invoke-WebRequest -Uri $SourcePath -OutFile $InstallZip
    }
    
    if ($InstalationsFound -eq 1) {
        remove-item $InstallPath -Recurse -Force        
    }

    New-Item -Path $InstallPath

    ubzi



    exit
}


Write-Error -Message "$Name encoutered an unknown situation, execution aborted."
exit



