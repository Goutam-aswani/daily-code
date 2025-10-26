@echo off
setlocal enabledelayedexpansion

REM Configuration - EDIT THESE VALUES
set REPO_PATH=z:\automation
set REMOTE_NAME=origin
set BRANCH_NAME=main

REM GitHub credentials - ALREADY CONFIGURED
set GIT_USERNAME=Goutam-aswani
set GIT_EMAIL=goutamaswani43@gmail.com

echo ========================================
echo Git Auto Commit and Push Script
echo ========================================
echo.

REM Check if Git is installed
echo [1/6] Checking Git installation...
git --version > nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed
    echo Please install from: https://git-scm.com/
    exit /b 1
)
echo OK - Git found
echo.

REM Change to repository directory
echo [2/6] Changing to repository directory...
cd /d "%REPO_PATH%"
if errorlevel 1 (
    echo ERROR: Failed to change directory to %REPO_PATH%
    exit /b 1
)
echo OK - In directory: %CD%
echo.

REM Configure Git user (required for commits)
echo [3/6] Configuring Git user...
git config user.name "%GIT_USERNAME%"
git config user.email "%GIT_EMAIL%"
if errorlevel 1 (
    echo ERROR: Failed to configure Git user
    exit /b 1
)
echo OK - Git user configured
echo.

REM Enable Git Credential Manager (if not already enabled)
git config --global credential.helper manager-core > nul 2>&1

REM Check if there are changes to commit
echo [4/6] Checking for changes...
git status --porcelain > temp_status.txt 2>&1
if errorlevel 1 (
    echo ERROR: Not a Git repository or Git command failed
    del temp_status.txt 2>nul
    exit /b 1
)

REM Check if status output is empty
for %%A in (temp_status.txt) do set STATUS_SIZE=%%~zA
del temp_status.txt 2>nul

if %STATUS_SIZE%==0 (
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
REM Push to remote
echo [5/6] Pushing to %REMOTE_NAME%/%BRANCH_NAME%...
echo NOTE: If this is your first push, Git Credential Manager will prompt for authentication.
echo You can use your GitHub Personal Access Token as the password.
echo.
git push %REMOTE_NAME% %BRANCH_NAME%
if errorlevel 1 (
    echo.
    echo ERROR: Push failed
    echo.
    echo Common solutions:
    echo   1. Authentication: Use a GitHub Personal Access Token
    echo      Create one at: https://github.com/settings/tokens
    echo      Select scopes: repo (full control)
    echo.
    echo   2. First push: Try 'git push -u origin main'
    echo.
    echo   3. Check remote: git remote -v
    echo.
    exit /b 1
)
echo OK - Pushed successfully
echo.

REM Summary
echo [6/6] Operations completed
echo ========================================
echo Git operations completed at %date% %time%
echo ========================================
echo.
pause
