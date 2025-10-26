# Git Auto-Push Shutdown Script Installer
# Run this script as Administrator to set up auto-push on shutdown

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Git Auto-Push on Shutdown - Installer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Right-click this script and select 'Run as Administrator'" -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

Write-Host "[1/4] Checking source script..." -ForegroundColor Yellow
$sourceScript = "z:\automation\git-auto-push-shutdown.bat"
if (-not (Test-Path $sourceScript)) {
    Write-Host "ERROR: Source script not found: $sourceScript" -ForegroundColor Red
    pause
    exit 1
}
Write-Host "OK - Script found" -ForegroundColor Green
Write-Host ""

Write-Host "[2/4] Creating Group Policy shutdown scripts folder..." -ForegroundColor Yellow
$shutdownDir = "C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown"
try {
    New-Item -ItemType Directory -Path $shutdownDir -Force | Out-Null
    Write-Host "OK - Folder created: $shutdownDir" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to create folder: $_" -ForegroundColor Red
    pause
    exit 1
}
Write-Host ""

Write-Host "[3/4] Copying shutdown script..." -ForegroundColor Yellow
try {
    Copy-Item $sourceScript -Destination $shutdownDir -Force
    Write-Host "OK - Script copied successfully" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to copy script: $_" -ForegroundColor Red
    pause
    exit 1
}
Write-Host ""

Write-Host "[4/4] Updating Group Policy..." -ForegroundColor Yellow
try {
    gpupdate /force | Out-Null
    Write-Host "OK - Group Policy updated" -ForegroundColor Green
} catch {
    Write-Host "WARNING: Group Policy update may have failed" -ForegroundColor Yellow
}
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installation Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Open Group Policy Editor (Win+R, type: gpedit.msc)"
Write-Host "2. Navigate to: Computer Configuration → Windows Settings → Scripts → Shutdown"
Write-Host "3. Double-click 'Shutdown'"
Write-Host "4. Click 'Add' → 'Browse'"
Write-Host "5. Navigate to: C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown"
Write-Host "6. Select 'git-auto-push-shutdown.bat'"
Write-Host "7. Click OK → Apply → OK"
Write-Host ""
Write-Host "OR run this to open Group Policy Editor now:" -ForegroundColor Cyan
Write-Host "    gpedit.msc" -ForegroundColor White
Write-Host ""
Write-Host "See SHUTDOWN-SETUP.md for detailed instructions." -ForegroundColor Gray
Write-Host ""

$openGP = Read-Host "Open Group Policy Editor now? (y/n)"
if ($openGP -eq 'y' -or $openGP -eq 'Y') {
    Start-Process gpedit.msc
    Write-Host ""
    Write-Host "Group Policy Editor opened!" -ForegroundColor Green
    Write-Host "Follow the Next Steps above to complete setup." -ForegroundColor Yellow
}

Write-Host ""
pause
