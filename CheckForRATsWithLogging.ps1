
# Define the log file path
$logFilePath = "C:\Users\$env:UserName\Desktop\CheckForRATsLog.txt"

# Function to write output to both console and log file
function Write-Log {
    param (
        [Parameter(Mandatory = $true)]
        [string]$message
    )
    Write-Output $message
    $message | Out-File -FilePath $logFilePath -Append
}

# Check for suspicious processes
Write-Log "Checking for suspicious processes..."
$suspiciousProcesses = @('svchost.exe', 'explorer.exe', 'taskmgr.exe', 'regsvr32.exe')
Get-Process | Where-Object { $suspiciousProcesses -contains $_.ProcessName } | ForEach-Object {
    Write-Log "Suspicious process found: $($_.ProcessName) (ID: $($_.Id))"
}

# Check for unusual network connections
Write-Log "Checking for unusual network connections..."
Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' -and $_.RemoteAddress -ne '127.0.0.1' } | ForEach-Object {
    $process = Get-Process -Id $_.OwningProcess
    Write-Log "Unusual connection found: $($_.RemoteAddress) (Process: $($process.ProcessName), ID: $($process.Id))"
}

# Check for new files in common locations
Write-Log "Checking for new files in common locations..."
$pathsToCheck = @("C:\Users\$env:UserName\AppData\Roaming", "C:\Users\$env:UserName\AppData\Local", "C:\ProgramData")
$daysToCheck = 7

foreach ($path in $pathsToCheck) {
    Write-Log "Checking path: $path"
    Get-ChildItem -Path $path -Recurse -File | Where-Object { $_.CreationTime -gt (Get-Date).AddDays(-$daysToCheck) } | ForEach-Object {
        Write-Log "New file found: $($_.FullName) (Created: $($_.CreationTime))"
    }
}

# Check for unusual scheduled tasks
Write-Log "Checking for unusual scheduled tasks..."
Get-ScheduledTask | Where-Object { $_.TaskPath -notlike '\Microsoft\*' } | ForEach-Object {
    Write-Log "Unusual scheduled task found: $($_.TaskName)"
}

# Check for unusual startup items
Write-Log "Checking for unusual startup items..."
$registryPaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
)

foreach ($path in $registryPaths) {
    Write-Log "Checking registry path: $path"
    Get-ItemProperty -Path $path | ForEach-Object {
        $_.PSObject.Properties | Where-Object { $_.Name -ne "PSPath" -and $_.Name -ne "PSParentPath" -and $_.Name -ne "PSChildName" -and $_.Name -ne "PSDrive" -and $_.Name -ne "PSProvider" } | ForEach-Object {
            Write-Log "Startup item found: $($_.Name) - $($_.Value)"
        }
    }
}

Write-Log "Check completed."
