#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

. "$PSScriptRoot\..\lib\console.ps1"

# ── winget ────────────────────────────────────────────────────────────────────

Write-CenterText "CHECKING WINGET"

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "winget is not available. Install 'App Installer' from the Microsoft Store."
    exit 1
}

Write-Success "winget is available: $(winget --version)"

# ── Helpers ───────────────────────────────────────────────────────────────────

function Install-WingetPackage {
    param([string]$PackageId)

    $installed = winget list --id $PackageId --exact 2>$null | Select-String $PackageId
    if ($installed) {
        Write-Ok "Package '$PackageId' is already installed"
    } else {
        Write-Log "Installing '$PackageId'..."
        winget install --id $PackageId --exact --silent --accept-package-agreements --accept-source-agreements
        Write-Ok "Installed '$PackageId'"
    }
}

# ── Packages ──────────────────────────────────────────────────────────────────

. "$PSScriptRoot\deps\windows\packages.ps1"

Write-CenterText "INSTALLING PACKAGES"

foreach ($package in $PACKAGES) {
    Install-WingetPackage -PackageId $package
}

# ── Oh My Posh ────────────────────────────────────────────────────────────────

Write-CenterText "INSTALLING OH-MY-POSH"

if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Info "Installing Oh My Posh..."
    winget install --id JanDeDobbeleer.OhMyPosh --exact --silent --accept-package-agreements --accept-source-agreements
    Write-Success "Oh My Posh installed"
} else {
    Write-Log "Oh My Posh is already installed: $(oh-my-posh --version)"
}

# ── Git config ────────────────────────────────────────────────────────────────

Write-CenterText "CONFIGURING GIT"

if (-not (git config --global user.name 2>$null)) {
    Write-Info "Git user.name is not set. Please configure it manually:"
    Write-Info "  git config --global user.name 'Your Name'"
    Write-Info "  git config --global user.email 'you@example.com'"
} else {
    Write-Ok "Git is already configured as: $(git config --global user.name)"
}

# ─────────────────────────────────────────────────────────────────────────────

Write-CenterText "BOOTSTRAPPING DONE"
