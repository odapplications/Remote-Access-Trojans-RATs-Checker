
# Remote Access Trojans (RATs) Checker

A PowerShell script to scan your Windows computer for potential Remote Access Trojans (RATs). This script checks for suspicious processes, unusual network connections, new files in common locations, unusual scheduled tasks, and startup items. 

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
  - [Easy Mode](#easy-mode)
  - [Dev Mode](#dev-mode)
- [Understanding the Output](#understanding-the-output)
  - [Suspicious Processes](#suspicious-processes)
  - [Unusual Network Connections](#unusual-network-connections)
  - [New Files](#new-files)
  - [Unusual Scheduled Tasks](#unusual-scheduled-tasks)
  - [Unusual Startup Items](#unusual-startup-items)
- [Contributing](#contributing)
- [License](#license)

## Features
- **Suspicious Processes**: Identifies processes that could potentially be RATs.
- **Unusual Network Connections**: Checks for unexpected connections that might indicate unauthorized access.
- **New Files**: Scans for newly created files in common directories.
- **Unusual Scheduled Tasks**: Detects scheduled tasks that may be used to maintain persistence.
- **Unusual Startup Items**: Identifies startup items that could be used to launch RATs on startup.

## Prerequisites
- Windows operating system
- PowerShell installed on your system

## Installation
1. Clone this repository to your local machine:
   ```sh
   git clone https://github.com/odapplications/Remote-Access-Trojans-RATs-Checker.git
   ```

2. Navigate to the directory:
   ```sh
   cd Remote-Access-Trojans-RATs-Checker
   ```

## Usage

### Easy Mode
1. Put the `CheckForRATsWithLogging.ps1` file on the Desktop.
2. Open PowerShell or Command Prompt.
3. Run the following command, replacing `Shane` with your username:

   ```sh
   powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Users\Shane\Desktop\CheckForRATsWithLogging.ps1"
   ```

### Dev Mode
1. Open a text editor.
2. Copy and paste the code from the `CheckForRATsWithLogging.ps1` file in the repository.
3. Make any necessary adjustments for personal use.
4. Save the file with any desired name and change the file extension from `.txt` to `.ps1`.
5. Follow the steps in Easy Mode, adjusting the file name and path as needed.

## Understanding the Output
The script generates a log file (`CheckForRATsLog.txt`) on your Desktop. This log contains detailed information about the scan results. Below is an explanation of what to look for:

### Suspicious Processes
- **Normal:** Common system processes like `svchost.exe`, `explorer.exe`, `taskmgr.exe` running as expected.
- **Suspicious:** Multiple instances of these processes, especially if they are consuming high resources or associated with unknown executables.

### Unusual Network Connections
- **Normal:** Connections to known and expected IP addresses.
- **Suspicious:** Connections to unknown or unusual IP addresses, especially from processes that shouldn't be connecting to the internet.

### New Files
- **Normal:** Files created by legitimate applications or updates.
- **Suspicious:** Unexpected executable files in directories like `AppData` or `ProgramData`.

### Unusual Scheduled Tasks
- **Normal:** Tasks created by the operating system or known applications.
- **Suspicious:** Tasks with unfamiliar names or those running unknown executables.

### Unusual Startup Items
- **Normal:** Startup items associated with known software.
- **Suspicious:** Items pointing to unknown executables or those located in unusual directories.
