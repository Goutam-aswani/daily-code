# Git Auto-Push Scheduler Setup

This folder contains scripts to automatically commit and push changes to GitHub.

## Files

- **git-auto-push.bat** - Main script that commits and pushes changes
- **GitAutoPush-DailyTask.xml** - Windows Task Scheduler configuration (runs daily at 6 PM)

## Quick Setup

### Option 1: Install Daily Task (Runs every day at 6 PM)

```powershell
# Import the scheduled task (run as Administrator)
schtasks /create /tn "GitAutoPush-Daily" /xml "z:\automation\GitAutoPush-DailyTask.xml"
```

### Option 2: Custom Schedule

Create your own schedule using Task Scheduler GUI:
1. Open Task Scheduler (Win + R, type `taskschd.msc`)
2. Click "Import Task" and select `GitAutoPush-DailyTask.xml`
3. Edit the trigger to your preferred schedule (hourly, on login, etc.)

### Option 3: Manual Run

Double-click `git-auto-push.bat` anytime to run manually.

## Task Configuration Details

- **Runs**: Daily at 6:00 PM
- **Only when**: Network is available
- **Battery**: Runs even on battery power
- **Timeout**: 10 minutes max execution time
- **Missed runs**: Will run at next opportunity if computer was off

## Manage the Task

```powershell
# Check if task is installed
schtasks /query /tn "GitAutoPush-Daily"

# Run task now (test)
schtasks /run /tn "GitAutoPush-Daily"

# Disable task
schtasks /change /tn "GitAutoPush-Daily" /disable

# Enable task
schtasks /change /tn "GitAutoPush-Daily" /enable

# Delete task
schtasks /delete /tn "GitAutoPush-Daily" /f
```

## View Task Logs

```powershell
# Open Event Viewer to see task history
eventvwr.msc
# Navigate to: Task Scheduler Library > GitAutoPush-Daily > History
```

## Customize Schedule

Edit the XML file `<StartBoundary>` line to change the time:
- Daily at 6 PM: `<StartBoundary>2025-10-27T18:00:00</StartBoundary>`
- Daily at 9 AM: `<StartBoundary>2025-10-27T09:00:00</StartBoundary>`
- Daily at midnight: `<StartBoundary>2025-10-27T00:00:00</StartBoundary>`

For hourly tasks, change the trigger type in Task Scheduler GUI or create a new XML.

## Authentication

On first push, Git Credential Manager will prompt for:
- Username: `Goutam-aswani`
- Password: GitHub Personal Access Token (create at https://github.com/settings/tokens)

Credentials are saved after first auth - future runs are automatic.

## Troubleshooting

**Task not running?**
- Check Task Scheduler for errors in History tab
- Ensure network is available
- Verify script path in task action is correct

**Authentication fails?**
- Run `git-auto-push.bat` manually first to set up credentials
- Ensure Personal Access Token has `repo` scope

**No changes detected?**
- Normal behavior if no files changed since last run
- Task will skip commit but still attempt push
