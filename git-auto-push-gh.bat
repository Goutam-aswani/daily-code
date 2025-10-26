@echo off
setlocal enabledelayedexpansion

REM Configuration - EDIT THESE VALUES
set REPO_PATH=z:\automation
set REMOTE_NAME=origin
set BRANCH_NAME=main

REM GitHub credentials - EDIT THESE
set GIT_USERNAME=Goutam-aswani
set GIT_EMAIL=goutamaswani43@gmail.com

echo ========================================
echo Git Auto Commit and Push Script (GitHub CLI)
echo ========================================
echo.

REM Check if GitHub CLI is installed
echo [1/7] Checking GitHub CLI...
gh --version > nul 2>&1
if errorlevel 1 (
    echo ERROR: GitHub CLI (gh) is not installed
    echo Please install from: https://cli.github.com/
    exit /b 1
)
echo OK - GitHub CLI found
echo.

REM Check GitHub CLI authentication
echo [2/7] Checking GitHub authentication...
gh auth status > nul 2>&1
if errorlevel 1 (
    echo WARNING: Not authenticated with GitHub
    echo Running GitHub login...
    echo.
    gh auth login
    if errorlevel 1 (
        echo ERROR: GitHub authentication failed
        exit /b 1
    )
)
echo OK - Authenticated with GitHub
echo.

REM Change to repository directory
echo [3/7] Changing to repository directory...
cd /d "%REPO_PATH%"
if errorlevel 1 (
    echo ERROR: Failed to change directory to %REPO_PATH%
    exit /b 1
)
echo OK - In directory: %CD%
echo.

REM Configure Git user (required for commits)
echo [4/7] Configuring Git user...
git config user.name "%GIT_USERNAME%"
git config user.email "%GIT_EMAIL%"
if errorlevel 1 (
    echo ERROR: Failed to configure Git user
    exit /b 1
)
echo OK - Git user configured
echo.

REM Check if there are changes to commit
echo [5/7] Checking for changes...
git status --porcelain > nul 2>&1
if errorlevel 1 (
    echo ERROR: Not a Git repository or Git command failed
    exit /b 1
)

git diff --quiet --exit-code
set HAS_CHANGES=%errorlevel%

git diff --cached --quiet --exit-code
set HAS_STAGED=%errorlevel%

if %HAS_CHANGES%==0 if %HAS_STAGED%==0 (
    echo No changes detected. Nothing to commit.
    echo.
    goto :push_only
)
echo OK - Changes detected
echo.

REM Stage all changes
echo Staging changes...
git add .
if errorlevel 1 (
    echo ERROR: Failed to stage changes
    exit /b 1
)
echo OK - All changes staged
echo.

REM Create commit with timestamp
echo Creating commit...
set COMMIT_MSG=Auto commit - %date% %time%
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    echo ERROR: Failed to create commit
    exit /b 1
)
echo OK - Commit created: %COMMIT_MSG%
echo.

:push_only
REM Push to remote using GitHub CLI
echo [6/7] Pushing to %REMOTE_NAME%/%BRANCH_NAME%...
git push %REMOTE_NAME% %BRANCH_NAME%
if errorlevel 1 (
    echo ERROR: Push failed
    echo Possible reasons:
    echo   - Remote branch does not exist
    echo   - Network connection issues
    echo   - Permission denied
    echo.
    echo You may need to run: git push -u %REMOTE_NAME% %BRANCH_NAME%
    exit /b 1
)
echo OK - Pushed successfully
echo.

REM Summary
echo [7/7] Operations completed
echo ========================================
echo Git operations completed at %date% %time%
echo ========================================
echo.
pause