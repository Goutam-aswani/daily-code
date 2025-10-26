# Git Auto-Push Keyboard Shortcuts - Quick Setup
# This script creates desktop shortcuts and guides you to assign keyboard shortcuts

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Git Auto-Push Keyboard Shortcuts Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/3] Creating desktop shortcuts..." -ForegroundColor Yellow

try {
    $WshShell = New-Object -ComObject WScript.Shell
    
    # Shutdown shortcut
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Git Push + Shutdown.lnk")
    $Shortcut.TargetPath = "z:\automation\shutdown-with-push.bat"
    $Shortcut.WorkingDirectory = "z:\automation"
    $Shortcut.Description = "Push code to GitHub and shutdown (Ctrl+Alt+S)"
    $Shortcut.Save()
    Write-Host "  ✓ Created: Git Push + Shutdown.lnk" -ForegroundColor Green
    
    # Restart shortcut
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Git Push + Restart.lnk")
    $Shortcut.TargetPath = "z:\automation\restart-with-push.bat"
    $Shortcut.WorkingDirectory = "z:\automation"
    $Shortcut.Description = "Push code to GitHub and restart (Ctrl+Alt+R)"
    $Shortcut.Save()
    Write-Host "  ✓ Created: Git Push + Restart.lnk" -ForegroundColor Green
    
    # Manual push shortcut
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Git Push.lnk")
    $Shortcut.TargetPath = "z:\automation\git-auto-push.bat"
    $Shortcut.WorkingDirectory = "z:\automation"
    $Shortcut.Description = "Push code to GitHub manually (Ctrl+Alt+P)"
    $Shortcut.Save()
    Write-Host "  ✓ Created: Git Push.lnk" -ForegroundColor Green
    
} catch {
    Write-Host "  ✗ Error creating shortcuts: $_" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "[2/3] Shortcuts created successfully!" -ForegroundColor Green
Write-Host ""

Write-Host "[3/3] Next steps - Assign keyboard shortcuts:" -ForegroundColor Yellow
Write-Host ""
Write-Host "For each desktop shortcut, do the following:" -ForegroundColor White
Write-Host "  1. Right-click the shortcut → Properties" -ForegroundColor Gray
Write-Host "  2. Click in 'Shortcut key' field" -ForegroundColor Gray
Write-Host "  3. Press the key combination you want" -ForegroundColor Gray
Write-Host "  4. Click OK" -ForegroundColor Gray
Write-Host ""

Write-Host "Recommended keyboard shortcuts:" -ForegroundColor Cyan
Write-Host "  • Git Push + Shutdown  →  Ctrl + Alt + S" -ForegroundColor White
Write-Host "  • Git Push + Restart   →  Ctrl + Alt + R" -ForegroundColor White
Write-Host "  • Git Push             →  Ctrl + Alt + P" -ForegroundColor White
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Desktop shortcuts are on your desktop." -ForegroundColor White
Write-Host "Assign keyboard shortcuts following the steps above." -ForegroundColor White
Write-Host ""
Write-Host "See KEYBOARD-SHORTCUTS-SETUP.md for more details." -ForegroundColor Gray
Write-Host ""

$openDesktop = Read-Host "Open desktop folder now to see shortcuts? (y/n)"
if ($openDesktop -eq 'y' -or $openDesktop -eq 'Y') {
    explorer.exe $env:USERPROFILE\Desktop
}

Write-Host ""
pause
