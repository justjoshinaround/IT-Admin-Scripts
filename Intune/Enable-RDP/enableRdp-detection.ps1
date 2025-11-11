## Detection Script: Check if RDP is enabled and firewall is open

## Check registry setting
$rdpEnabled = -not ((Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections").fDenyTSConnections)

## Check firewall rules
$firewallRules = Get-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction SilentlyContinue |
                 Where-Object { $_.Enabled -eq "True" }

if ($rdpEnabled -and $firewallRules.Count -gt 0) {
    Write-Output "RDP is enabled and firewall rules are active"
    exit 0
}
else {
    Write-Output "RDP not fully enabled"
    exit 1
}
