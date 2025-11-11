## Remediation Script: Disable RDP and firewall rules

## Disable RDP via registry
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" -Value 1

## Disable firewall rules for Remote Desktop
Disable-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction SilentlyContinue

Write-Output "RDP has been disabled and firewall rules turned off"
exit 0
