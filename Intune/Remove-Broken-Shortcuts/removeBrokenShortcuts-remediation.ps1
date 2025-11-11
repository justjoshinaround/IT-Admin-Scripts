## Remediation Script - Remove Broken Shortcuts (Start Menu + Desktop)

$shortcutLocations = @(
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs",
    "C:\Users\Public\Desktop"
)

## Add all user profile Desktops
$profiles = Get-ChildItem "C:\Users" -Directory | Where-Object {
    Test-Path "$($_.FullName)\Desktop"
}
foreach ($profile in $profiles) {
    $shortcutLocations += "$($profile.FullName)\Desktop"
}

foreach ($path in $shortcutLocations) {
    if (Test-Path $path) {
        Get-ChildItem -Path $path -Filter *.lnk -Recurse | ForEach-Object {
            try {
                $shell = New-Object -ComObject WScript.Shell
                $targetPath = $shell.CreateShortcut($_.FullName).TargetPath
                if (-not [string]::IsNullOrWhiteSpace($targetPath) -and -not (Test-Path $targetPath)) {
                    Write-Output "Removing broken shortcut: $($_.FullName)"
                    Remove-Item $_.FullName -Force
                }
            } catch {
                ## Skip errors
            }
        }
    }
}
