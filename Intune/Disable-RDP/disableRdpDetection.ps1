## Detection Script: Check if RDP is disabled and firewall rules are off

## Check registry setting (fDenyTSConnections = 1 means RDP disabled)
$rdpDisabled = ((Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections").fDenyTSConnections -eq 1)

## Check firewall rules (none of the Remote Desktop rules should be enabled)
$firewallRules = Get-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction SilentlyContinue |
                 Where-Object { $_.Enabled -eq "True" }

if ($rdpDisabled -and $firewallRules.Count -eq 0) {
    Write-Output "RDP is disabled and firewall rules are off"
    exit 0
}
else {
    Write-Output "RDP still enabled"
    exit 1
}
