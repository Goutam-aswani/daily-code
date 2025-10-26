# Quick Git Setup - Simple Interactive Script
# Run this in any VS Code folder to set up Git

function Quick-GitSetup {
    Clear-Host
    Write-Host "=== Git Setup for Current Folder ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Current Location: $(Get-Location)" -ForegroundColor Yellow
    Write-Host ""
    
    # Check if git repo exists
    $gitExists = Test-Path ".git"
    
    if ($gitExists) {
        Write-Host "[OK] Git repository already exists here!" -ForegroundColor Green
        Write-Host ""
        git remote -v
        Write-Host ""
        Write-Host "Already configured. Nothing to do!" -ForegroundColor Green
        return
    }
    
    Write-Host "No Git repository found." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "What would you like to do?" -ForegroundColor Cyan
    Write-Host "  1. Create NEW repo and push to GitHub"
    Write-Host "  2. Connect to EXISTING GitHub repo"
    Write-Host "  3. Just initialize local Git (no GitHub)"
    Write-Host "  4. Skip (do nothing)"
    Write-Host ""
    
    $choice = Read-Host "Enter choice (1-4)"
    
    switch ($choice) {
        "1" {
            Write-Host ""
            $repoName = Read-Host "Enter new GitHub repo name (e.g., my-project)"
            Write-Host ""
            Write-Host "[INFO] Steps:" -ForegroundColor Cyan
            Write-Host "  1. Go to https://github.com/new"
            Write-Host "  2. Create repo named: $repoName"
            Write-Host "  3. Press Enter here when done"
            Read-Host ""
            
            git init
            git config user.name "Goutam-aswani"
            git config user.email "goutamaswani43@gmail.com"
            git add .
            git commit -m "Initial commit"
            git branch -M main
            git remote add origin "https://github.com/Goutam-aswani/$repoName.git"
            git push -u origin main
            
            Write-Host ""
            Write-Host "[OK] Done! Repo connected and pushed!" -ForegroundColor Green
        }
        
        "2" {
            Write-Host ""
            $repoUrl = Read-Host "Enter GitHub repo URL (https://github.com/...)"
            
            git init
            git config user.name "Goutam-aswani"
            git config user.email "goutamaswani43@gmail.com"
            git remote add origin $repoUrl
            git fetch
            git branch -M main
            git pull origin main --allow-unrelated-histories
            
            Write-Host ""
            Write-Host "[OK] Connected to existing repo!" -ForegroundColor Green
        }
        
        "3" {
            git init
            git config user.name "Goutam-aswani"
            git config user.email "goutamaswani43@gmail.com"
            
            Write-Host ""
            Write-Host "[OK] Local Git initialized!" -ForegroundColor Green
        }
        
        "4" {
            Write-Host ""
            Write-Host "Skipped." -ForegroundColor Gray
        }
        
        default {
            Write-Host ""
            Write-Host "Invalid choice. Cancelled." -ForegroundColor Red
        }
    }
}

# Run it
Quick-GitSetup
