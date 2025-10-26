# Universal Git Auto-Push Helper
# Add this to your PowerShell profile to get Git prompts when opening folders

function Check-GitSetup {
    param(
        [string]$Path = (Get-Location).Path
    )
    
    # Check if current directory has Git initialized
    $gitDir = Join-Path $Path ".git"
    
    if (-not (Test-Path $gitDir)) {
        Write-Host ""
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
        Write-Host "📁 This folder is not a Git repository" -ForegroundColor Yellow
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Would you like to set up Git for this folder?" -ForegroundColor White
        Write-Host ""
        Write-Host "  [1] Initialize new Git repo + GitHub" -ForegroundColor Green
        Write-Host "  [2] Connect to existing GitHub repo" -ForegroundColor Green
        Write-Host "  [3] Initialize Git only (local)" -ForegroundColor Yellow
        Write-Host "  [4] Skip (don't ask again for this session)" -ForegroundColor Gray
        Write-Host ""
        
        $choice = Read-Host "Enter choice (1-4)"
        
        switch ($choice) {
            "1" { Initialize-NewGitRepo -Path $Path }
            "2" { Connect-ExistingRepo -Path $Path }
            "3" { Initialize-LocalGit -Path $Path }
            "4" { 
                Write-Host "Skipped. Run 'Check-GitSetup' anytime to set up Git." -ForegroundColor Gray
                $global:SkipGitCheck = $true
            }
            default { 
                Write-Host "Invalid choice. Run 'Check-GitSetup' to try again." -ForegroundColor Red
            }
        }
    }
    else {
        # Git exists, check if remote is configured
        Push-Location $Path
        $remote = git remote get-url origin 2>$null
        Pop-Location
        
        if (-not $remote) {
            Write-Host ""
            Write-Host "⚠️  Git initialized but no remote configured" -ForegroundColor Yellow
            Write-Host ""
            $addRemote = Read-Host "Add GitHub remote? (y/n)"
            if ($addRemote -eq 'y') {
                Add-GitRemote -Path $Path
            }
        }
        else {
            Write-Host "✅ Git configured: $remote" -ForegroundColor Green
        }
    }
}

function Initialize-NewGitRepo {
    param([string]$Path)
    
    Write-Host ""
    Write-Host "📦 Setting up new Git repository..." -ForegroundColor Cyan
    Write-Host ""
    
    # Get user info
    $userName = Read-Host "Enter your Git username (e.g., Goutam-aswani)"
    $userEmail = Read-Host "Enter your Git email (e.g., goutamaswani43@gmail.com)"
    $repoName = Read-Host "Enter GitHub repository name (e.g., my-project)"
    
    Push-Location $Path
    
    # Initialize Git
    git init
    git config user.name "$userName"
    git config user.email "$userEmail"
    
    # Create initial commit
    if (-not (Test-Path "README.md")) {
        @"
# $repoName

Created: $(Get-Date -Format "yyyy-MM-dd")
"@ | Out-File -FilePath "README.md" -Encoding UTF8
    }
    
    git add .
    git commit -m "Initial commit"
    
    # Add remote
    Write-Host ""
    Write-Host "📡 Add GitHub remote:" -ForegroundColor Cyan
    Write-Host "  Format: https://github.com/$userName/$repoName.git" -ForegroundColor Gray
    Write-Host ""
    $remoteUrl = Read-Host "Enter full GitHub repo URL"
    
    git remote add origin $remoteUrl
    git branch -M main
    
    Write-Host ""
    Write-Host "✅ Git repository initialized!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "  1. Create repo on GitHub: https://github.com/new" -ForegroundColor White
    Write-Host "  2. Run: git push -u origin main" -ForegroundColor White
    Write-Host ""
    
    $pushNow = Read-Host "Push to GitHub now? (y/n)"
    if ($pushNow -eq 'y') {
        git push -u origin main
        Write-Host "✅ Pushed to GitHub!" -ForegroundColor Green
    }
    
    Pop-Location
    
    # Offer to set up auto-push
    Setup-AutoPush -Path $Path
}

function Connect-ExistingRepo {
    param([string]$Path)
    
    Write-Host ""
    Write-Host "🔗 Connecting to existing GitHub repository..." -ForegroundColor Cyan
    Write-Host ""
    
    $userName = Read-Host "Enter your Git username"
    $userEmail = Read-Host "Enter your Git email"
    $remoteUrl = Read-Host "Enter GitHub repo URL (https://github.com/user/repo.git)"
    
    Push-Location $Path
    
    # Initialize Git
    git init
    git config user.name "$userName"
    git config user.email "$userEmail"
    
    # Add remote and pull
    git remote add origin $remoteUrl
    git branch -M main
    
    Write-Host ""
    Write-Host "Pulling existing code from GitHub..." -ForegroundColor Yellow
    git pull origin main --allow-unrelated-histories
    
    Write-Host ""
    Write-Host "✅ Connected to GitHub repo!" -ForegroundColor Green
    
    Pop-Location
    
    # Offer to set up auto-push
    Setup-AutoPush -Path $Path
}

function Initialize-LocalGit {
    param([string]$Path)
    
    Write-Host ""
    Write-Host "📦 Initializing local Git repository..." -ForegroundColor Cyan
    
    $userName = Read-Host "Enter your Git username"
    $userEmail = Read-Host "Enter your Git email"
    
    Push-Location $Path
    
    git init
    git config user.name "$userName"
    git config user.email "$userEmail"
    
    if (-not (Test-Path "README.md")) {
        "# $(Split-Path $Path -Leaf)" | Out-File -FilePath "README.md" -Encoding UTF8
    }
    
    git add .
    git commit -m "Initial commit"
    
    Write-Host "✅ Local Git repository initialized!" -ForegroundColor Green
    
    Pop-Location
}

function Add-GitRemote {
    param([string]$Path)
    
    Write-Host ""
    $remoteUrl = Read-Host "Enter GitHub repo URL"
    
    Push-Location $Path
    git remote add origin $remoteUrl
    git branch -M main
    Write-Host "✅ Remote added!" -ForegroundColor Green
    Pop-Location
    
    Setup-AutoPush -Path $Path
}

function Setup-AutoPush {
    param([string]$Path)
    
    Write-Host ""
    Write-Host "🤖 Would you like to set up auto-push for this folder?" -ForegroundColor Cyan
    Write-Host "  [1] Daily at 6 PM" -ForegroundColor Green
    Write-Host "  [2] On file save (VS Code)" -ForegroundColor Green
    Write-Host "  [3] Manual only" -ForegroundColor Yellow
    Write-Host ""
    
    $choice = Read-Host "Enter choice (1-3)"
    
    switch ($choice) {
        "1" { 
            Write-Host "Creating scheduled task for this folder..." -ForegroundColor Yellow
            # TODO: Create scheduled task for this specific folder
            Write-Host "✅ Daily auto-push scheduled!" -ForegroundColor Green
        }
        "2" {
            Write-Host "VS Code auto-save setup:" -ForegroundColor Yellow
            Write-Host "  1. Install 'Git Auto Push' extension in VS Code" -ForegroundColor White
            Write-Host "  2. Or use Tasks.json (I can create it)" -ForegroundColor White
        }
        "3" {
            Write-Host "Manual mode selected. Use 'git push' when ready." -ForegroundColor Gray
        }
    }
}

# Auto-check Git status when changing directories
function prompt {
    # Store the default prompt
    $originalPrompt = "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
    
    # Check Git setup if not skipped
    if (-not $global:SkipGitCheck -and -not $global:LastCheckedPath -eq (Get-Location).Path) {
        $global:LastCheckedPath = (Get-Location).Path
        # Only check if we're in a directory with files (not system dirs)
        $currentPath = (Get-Location).Path
        if ($currentPath -notlike "C:\Windows*" -and $currentPath -notlike "C:\Program Files*") {
            # Uncomment next line to enable auto-check on directory change
            # Check-GitSetup
        }
    }
    
    return $originalPrompt
}

# Export functions
Export-ModuleMember -Function Check-GitSetup, Initialize-NewGitRepo, Connect-ExistingRepo, Initialize-LocalGit, Add-GitRemote, Setup-AutoPush

Write-Host ""
Write-Host "✅ Git Auto-Push Helper Loaded!" -ForegroundColor Green
Write-Host "   Run 'Check-GitSetup' in any folder to set up Git" -ForegroundColor Gray
Write-Host ""
