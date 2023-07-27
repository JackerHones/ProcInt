**Process Interrogator (ProcInt) - PowerShell Script**

## Description
The Process Interrogator (ProcInt) is a PowerShell script that allows you to search for and interrogate processes running on your system. It provides a simple command-line interface to search for processes by name, view detailed information about a selected process, and optionally terminate processes.

## How It Works
1. **Search for Processes**: When you run the script, it will prompt you to enter the name or part of the name of the process you want to interrogate. The script will then search for all processes that start with or contain the given sequence of letters.

2. **Select Process**: If the script finds matching processes, it will display a list of matching processes along with their process IDs. You will be asked to enter the number corresponding to the correct process you want to investigate.

3. **View Process Information**: After selecting a process, the script will display detailed information about the chosen process, such as the process ID, name, CPU usage, memory usage, and more.

4. **Optional: View Parent Process**: You will have the option to view the parent process of the selected process. If you choose to do so, the script will display information about the parent process.

5. **Optional: Terminate Process**: If you decide to terminate the process, the script will provide an option to do so. Upon confirmation, the selected process will be terminated.

6. **Continue or Exit**: After each interrogation, you will have the choice to continue searching for other processes or exit the script.

## Save Location
When you run the ProcInt script, it automatically generates a log file to track each session's output. The log file is saved in the same folder where the script is located. The log file's name follows the format "ProcIntYYYYMMDDHHmm.log," where YYYY is the year, MM is the month, DD is the day, HH is the hour, and mm is the minute of the script's execution.

## Usage
1. Download the ProcInt.ps1 script to your desired location on your Windows system.

2. Open PowerShell: Press `Windows Key + X`, then select `Windows PowerShell` or `Windows PowerShell (Admin)` from the menu.

3. Change the current directory: Use the `cd` command to navigate to the folder where you saved the ProcInt.ps1 script.

4. Run the script: Type `.\ProcInt.ps1` and press Enter to start the Process Interrogator.

5. Follow the on-screen instructions: The script will guide you through the process of searching, selecting, viewing, and potentially terminating processes.

## Note
- This script may require execution policy changes in PowerShell. If you encounter an error while running the script, you might need to set the execution policy to allow running scripts. To do this, run PowerShell as an administrator and execute the command `Set-ExecutionPolicy RemoteSigned` or `Set-ExecutionPolicy Unrestricted`.

- Use this script responsibly, especially when terminating processes, as terminating critical system processes can cause system instability or data loss.

- This script is intended for educational and informational purposes only. The author is not responsible for any damages caused by using this script.

**Author: JackerHones**
**Version: 1.0**
**Last Updated: 07/27/2023**
