## Enable RDP
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" -Value 0

## Enable firewall rules for RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
