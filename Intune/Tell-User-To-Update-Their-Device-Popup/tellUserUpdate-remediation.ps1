## Tells the user to update their dang device
## Run this script as the logged-on user

## Load required .NET assembly
Add-Type -AssemblyName PresentationFramework

## Define message
$PopupTitle = "Updates Required for Device Compliance"
$PopupText  = "This is a message from IT - Please update your device operating system as soon as possible.`n`nTo do so, hit the Windows key on your keyboard and type `"check for updates`". Run any updates that are available, including the update to Windows 11 if it is available.`n`nFor any questions or assistance with this matter, please contact the IT help desk at xxx.xxx.xxxx."

## Show popup to user
[System.Windows.MessageBox]::Show(
    $PopupText,
    $PopupTitle,
    'OK',
    'Warning'
)

## Log output for Intune reporting
Write-Output "User notified of required updates."
