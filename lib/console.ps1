# Console helpers — mirrors lib/console.sh for PowerShell

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-Ok {
    param([string]$Message)
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-Log {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Write-CenterText {
    param(
        [string]$Text,
        [int]$Width = 72
    )

    $termWidth = $Host.UI.RawUI.WindowSize.Width
    if ($termWidth -gt 0 -and $termWidth -lt $Width) { $Width = $termWidth }

    $fillChar = "="
    $padding = [math]::Floor(($Width - $Text.Length) / 2)
    $leftPad  = $fillChar * $padding
    $rightPad = $fillChar * ($Width - $padding - $Text.Length)

    Write-Host "$leftPad $Text $rightPad" -ForegroundColor Blue
}
