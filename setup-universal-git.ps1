# Universal Git Auto-Push Setup Script
# This script sets up Git auto-detection across all your VS Code projects

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Universal Git Auto-Push Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This will set up Git auto-detection for ALL your VS Code projects" -ForegroundColor White
Write-Host ""

# Step 1: Add module to PowerShell profile
Write-Host "[1/4] Setting up PowerShell profile..." -ForegroundColor Yellow

$profilePath = $PROFILE.CurrentUserAllHosts
$profileDir = Split-Path $profilePath -Parent

# Create profile directory if it doesn't exist
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# Copy the module to PowerShell modules folder
$modulesPath = Join-Path (Split-Path $profilePath -Parent) "Modules\GitAutoSetup"
if (-not (Test-Path $modulesPath)) {
    New-Item -ItemType Directory -Path $modulesPath -Force | Out-Null
}

Copy-Item "z:\automation\GitAutoSetup.psm1" -Destination $modulesPath -Force
Write-Host "  ✓ Module installed to: $modulesPath" -ForegroundColor Green

# Add import to profile
$importLine = "Import-Module GitAutoSetup -DisableNameChecking"
if (Test-Path $profilePath) {
    $profileContent = Get-Content $profilePath -Raw
    if ($profileContent -notlike "*GitAutoSetup*") {
        Add-Content -Path $profilePath -Value "`n# Git Auto-Setup Helper`n$importLine`n"
        Write-Host "  ✓ Added to PowerShell profile" -ForegroundColor Green
    }
    else {
        Write-Host "  ✓ Already in PowerShell profile" -ForegroundColor Green
    }
}
else {
    @"
# Git Auto-Setup Helper
$importLine
"@ | Out-File -FilePath $profilePath -Encoding UTF8
    Write-Host "  ✓ Created PowerShell profile" -ForegroundColor Green
}

Write-Host ""

# Step 2: Set up VS Code settings
Write-Host "[2/4] Configuring VS Code..." -ForegroundColor Yellow

$vscodeSettingsPath = "$env:APPDATA\Code\User\settings.json"

if (Test-Path $vscodeSettingsPath) {
    Write-Host "  ℹ VS Code settings found" -ForegroundColor Cyan
    Write-Host "  📄 Template settings saved to: vscode-settings-template.json" -ForegroundColor White
    Write-Host "  → Add these manually to your VS Code settings if desired" -ForegroundColor Gray
}
else {
    Write-Host "  ⚠ VS Code settings not found (VS Code may not be installed)" -ForegroundColor Yellow
}

Write-Host ""

# Step 3: Install recommended VS Code extensions
Write-Host "[3/4] Recommended VS Code extensions..." -ForegroundColor Yellow
Write-Host ""
Write-Host "  To enable Git auto-push in VS Code, install:" -ForegroundColor White
Write-Host "    • GitLens (eamodio.gitlens)" -ForegroundColor Cyan
Write-Host "    • Git Graph (mhutchie.git-graph)" -ForegroundColor Cyan
Write-Host ""

$installExtensions = Read-Host "Install recommended extensions now? (y/n)"

if ($installExtensions -eq 'y' -or $installExtensions -eq 'Y') {
    Write-Host ""
    Write-Host "  Installing extensions..." -ForegroundColor Yellow
    
    $extensions = @(
        "eamodio.gitlens",
        "mhutchie.git-graph"
    )
    
    foreach ($ext in $extensions) {
        try {
            & code --install-extension $ext --force 2>$null
            Write-Host "    ✓ Installed: $ext" -ForegroundColor Green
        }
        catch {
            Write-Host "    ✗ Failed to install: $ext" -ForegroundColor Red
        }
    }
}

Write-Host ""

# Step 4: Test setup
Write-Host "[4/4] Testing setup..." -ForegroundColor Yellow
Write-Host ""

Write-Host "  To test, open a new PowerShell window and run:" -ForegroundColor White
Write-Host "    Check-GitSetup" -ForegroundColor Cyan
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "How it works:" -ForegroundColor Yellow
Write-Host "  1. Open any folder in VS Code" -ForegroundColor White
Write-Host "  2. Open integrated terminal (Ctrl+`)" -ForegroundColor White
Write-Host "  3. Type: Check-GitSetup" -ForegroundColor Cyan
Write-Host "  4. Follow the prompts to connect to Git!" -ForegroundColor White
Write-Host ""

Write-Host "The helper will ask you:" -ForegroundColor Yellow
Write-Host "  • Do you want to initialize Git?" -ForegroundColor White
Write-Host "  • Connect to existing repo or create new?" -ForegroundColor White
Write-Host "  • What's your GitHub username/email?" -ForegroundColor White
Write-Host "  • Set up auto-push?" -ForegroundColor White
Write-Host ""

Write-Host "See UNIVERSAL-GIT-SETUP.md for full documentation." -ForegroundColor Gray
Write-Host ""

$openDocs = Read-Host "Open documentation now? (y/n)"
if ($openDocs -eq 'y' -or $openDocs -eq 'Y') {
    code "z:\automation\UNIVERSAL-GIT-SETUP.md"
}

Write-Host ""
Write-Host "⚠️  Important: Restart your terminal for changes to take effect!" -ForegroundColor Yellow
Write-Host ""

pause
