## Detection Script - Broken Shortcuts (Start Menu + Desktop)

$brokenShortcuts = @()

## Common shortcut locations
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
                    $brokenShortcuts += $_.FullName
                }
            } catch {
                # Skip errors
            }
        }
    }
}

if ($brokenShortcuts.Count -gt 0) {
    Write-Output "Found broken shortcuts:"
    $brokenShortcuts | ForEach-Object { Write-Output $_ }
    exit 1  # Non-compliant
} else {
    Write-Output "No broken shortcuts found"
    exit 0  # Compliant
}
