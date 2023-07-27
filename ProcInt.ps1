function Show-WelcomeBanner {
@"
██████╗ ██████╗  ██████╗  ██████╗██╗███╗   ██╗████████╗
██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║████╗  ██║╚══██╔══╝
██████╔╝██████╔╝██║   ██║██║     ██║██╔██╗ ██║   ██║   
██╔═══╝ ██╔══██╗██║   ██║██║     ██║██║╚██╗██║   ██║   
██║     ██║  ██║╚██████╔╝╚██████╗██║██║ ╚████║   ██║   
╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝╚═╝  ╚═══╝   ╚═╝   

Welcome to the Process Interrogator!
"@
}

function Show-LoadingBar {
    param (
        [int]$totalSteps,
        [int]$currentStep,
        [int]$barLength = 50
    )
    $percentComplete = [math]::Round(($currentStep / $totalSteps) * 100, 0)
    $completedLength = [math]::Round(($currentStep / $totalSteps) * $barLength, 0)
    $remainingLength = $barLength - $completedLength
    $loadingBar = "[" + "-" * $completedLength + (" " * $remainingLength) + "] $percentComplete%"
    Write-Host $loadingBar -NoNewline
}

function Show-ProcessInfo {
    param (
        $process
    )
    $process | Select-Object -Property *
}

function Get-UserConfirmation {
    param (
        [string]$question
    )
    $confirmation = Read-Host $question
    $confirmation.ToLower()
}

function Get-MatchingProcesses {
    param (
        [string]$processName
    )
    Get-Process | Where-Object { $_.ProcessName -like "*$processName*" }
}

function Get-UserProcessSelection {
    param (
        [array]$processes
    )
    $index = 0
    $processes | ForEach-Object {
        Write-Host "$index) $_.ProcessName ($_.Id)"
        $index++
    }
    $selectedIndex = Read-Host "Enter the number corresponding to the correct process:"
    $selectedProcess = $processes[$selectedIndex]
    $selectedProcess
}

function Show-ExitingMessage {
@"
████████╗██╗  ██╗ █████╗ ███╗   ██╗██╗  ██╗███████╗    ███████╗ ██████╗ ██████╗     ██╗   ██╗███████╗██╗███╗   ██╗ ██████╗ 
╚══██╔══╝██║  ██║██╔══██╗████╗  ██║██║ ██╔╝██╔════╝    ██╔════╝██╔═══██╗██╔══██╗    ██║   ██║██╔════╝██║████╗  ██║██╔════╝ 
   ██║   ███████║███████║██╔██╗ ██║█████╔╝ ███████╗    █████╗  ██║   ██║██████╔╝    ██║   ██║███████╗██║██╔██╗ ██║██║  ███╗
   ██║   ██╔══██║██╔══██║██║╚██╗██║██╔═██╗ ╚════██║    ██╔══╝  ██║   ██║██╔══██╗    ██║   ██║╚════██║██║██║╚██╗██║██║   ██║
   ██║   ██║  ██║██║  ██║██║ ╚████║██║  ██╗███████║    ██║     ╚██████╔╝██║  ██║    ╚██████╔╝███████║██║██║ ╚████║╚██████╔╝
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝    ╚═╝      ╚═════╝ ╚═╝  ╚═╝     ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 
                                                                                                                           
██████╗ ██████╗  ██████╗  ██████╗██╗███╗   ██╗████████╗                                                                    
██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║████╗  ██║╚══██╔══╝                                                                    
██████╔╝██████╔╝██║   ██║██║     ██║██╔██╗ ██║   ██║                                                                       
██╔═══╝ ██╔══██╗██║   ██║██║     ██║██║╚██╗██║   ██║                                                                       
██║     ██║  ██║╚██████╔╝╚██████╗██║██║ ╚████║   ██║                                                                       
╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝╚═╝  ╚═══╝   ╚═╝                                                                       
"@
}

function Get-LogFileName {
    $timestamp = Get-Date -Format "yyyyMMddHHmm"
    "ProcInt$timestamp.log"
}

function Log-Session {
    param (
        [string]$logFileName,
        [string]$content
    )
    $logFile = Join-Path $pwd $logFileName
    $content | Out-File -FilePath $logFile -Append
}

function Main {
    Show-WelcomeBanner

    $continue = $true
    $logFileName = Get-LogFileName

    while ($continue) {
        $processName = Read-Host "What is the name of the process you're interrogating? "
        $matchingProcesses = Get-MatchingProcesses $processName

        if ($matchingProcesses.Count -eq 0) {
            Write-Host "No processes found with the given name. Please try again."
            continue
        }

        $selectedProcess = Get-UserProcessSelection $matchingProcesses
        Show-ProcessInfo $selectedProcess

        $parentProcessChoice = Get-UserConfirmation "Would you like to see the parent process? (yes/no): "
        if ($parentProcessChoice -eq "yes") {
            Show-ProcessInfo $selectedProcess.Parent
        }
        else {
            $killProcessChoice = Get-UserConfirmation "Would you like to kill the process or return to the home menu? (kill/return): "
            if ($killProcessChoice -eq "kill") {
                try {
                    $selectedProcess.Kill()
                    Write-Host "Process $($selectedProcess.ProcessName) with ID $($selectedProcess.Id) has been terminated."
                }
                catch {
                    Write-Host "Failed to terminate the process: $_"
                }
            }
        }

        $continueChoice = Get-UserConfirmation "Do you want to continue interrogating processes? (yes/no): "
        if ($continueChoice -eq "no") {
            $continue = $false
            Show-ExitingMessage
        }

        # Logging session output
        $outputContent = "Process Name: $($selectedProcess.ProcessName), ID: $($selectedProcess.Id)"
        Log-Session -logFileName $logFileName -content $outputContent
    }
}

Set-Alias ProcInt Main
Main
