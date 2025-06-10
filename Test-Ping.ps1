#Author: Denis Martinez

# Script: Internet Connection Check
# Description: Sends ICMP ping to a public DNS server to check if your connection is working.

# Creating a simple ping function
function Test-ConnectionInteractive {
    # Get user input

    $target = Read-Host "Enter a website to test a connection or IP Address"
    $PingCount = Read-Host "Enter the number of pings to send"

    Write-Host "Pinging $host ($PingCount times)..." -ForegroundColor White

    $results = Test-Connection -ComputerName $target -Count $PingCount -ErrorAction SilentlyContinue

    if ($results) {
    $sent = $PingCount
    $received = $results.Count
    $lost = $sent - $received
    $lossPercent = [math]::Round(($lost/$sent) * 100, 2)
    $avgRTT = ($results | Measure-Object -Property ResponseTime -Average).Average

    Write-Host "Internet Connection Results"
    Write-Host "Host:          $target"
    Write-Host "Sent:          $sent"
    Write-Host "Received:      $received"
    Write-Host "Lost:          $lost"
    Write-Host "Packet Loss:   $lossPercent%"
    Write-Host "Avg Response:  $avgRTT ms"
    }else {
        Write-Host "Host is not reachable. No response." -ForegroundColor Red
    }
}

# Run the script
Test-ConnectionInteractive