# Git Auto-Push on Shutdown Setup

**This setup ensures your code is automatically pushed to GitHub every time you shut down or restart your PC.**

## 🎯 Best Option: Group Policy Shutdown Script

Windows Task Scheduler doesn't directly support "before shutdown" triggers reliably, so we'll use Group Policy shutdown scripts instead.

---

## ⚡ Quick Setup (Recommended)

Run this command in PowerShell **as Administrator**:

```powershell
# Copy shutdown script to Windows Group Policy folder
$shutdownDir = "C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown"
New-Item -ItemType Directory -Path $shutdownDir -Force
Copy-Item "z:\automation\git-auto-push-shutdown.bat" -Destination $shutdownDir

# Open Local Group Policy Editor
gpedit.msc
```

Then in Group Policy Editor:
1. Navigate to: **Computer Configuration** → **Windows Settings** → **Scripts (Startup/Shutdown)**
2. Double-click **Shutdown**
3. Click **Add** → **Browse**
4. Navigate to: `C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown`
5. Select `git-auto-push-shutdown.bat`
6. Click **OK** → **Apply** → **OK**

**Done!** Your script will now run before every shutdown/restart.

---

## 🔄 Alternative: Task Scheduler with Logoff Trigger

If you don't have access to Group Policy (Windows Home edition), use this:

```powershell
# Install the logoff trigger task
schtasks /create /tn "GitAutoPush-OnLogoff" /tr "z:\automation\git-auto-push-shutdown.bat" /sc ONEVENT /ec System /mo "*[System[Provider[@Name='User32'] and EventID=1074]]" /ru "%USERNAME%" /f
```

This triggers on system shutdown/restart events.

---

## 📋 Manual Setup for Group Policy

### Step 1: Copy the Script

```powershell
# Run as Administrator
$shutdownDir = "C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown"
New-Item -ItemType Directory -Path $shutdownDir -Force
Copy-Item "z:\automation\git-auto-push-shutdown.bat" -Destination $shutdownDir
```

### Step 2: Configure Group Policy

1. Press `Win + R`, type `gpedit.msc`, press Enter
2. Navigate to:
   ```
   Computer Configuration
     └── Windows Settings
         └── Scripts (Startup/Shutdown)
   ```
3. Double-click **Shutdown**
4. Click **Add** button
5. Click **Browse** button
6. Navigate to: `C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown`
7. Select `git-auto-push-shutdown.bat`
8. Click **Open** → **OK**
9. Click **Apply** → **OK**

### Step 3: Test It

```powershell
# Force Group Policy update
gpupdate /force

# Test shutdown (will actually shut down!)
shutdown /s /t 10 /c "Testing auto-push on shutdown"

# Cancel if needed
shutdown /a
```

---

## 🧪 Testing Without Shutdown

Test the shutdown script manually:

```powershell
z:\automation\git-auto-push-shutdown.bat
```

This runs silently (no output unless there's an error).

---

## ⚙️ How It Works

The shutdown script (`git-auto-push-shutdown.bat`) is optimized for speed:
- **Silent operation** - No console output (runs in background)
- **Fast execution** - Completes in 1-3 seconds
- **Error tolerant** - Won't block shutdown if Git fails
- **Smart detection** - Only commits if there are actual changes

**Execution flow:**
1. Windows triggers shutdown
2. Script runs automatically
3. Checks for changes in `z:\automation`
4. If changes: stages → commits → pushes
5. If no changes: just ensures sync
6. Shutdown continues (won't delay more than 5 seconds)

---

## 🔍 Verify Setup

### Check Group Policy:
```powershell
gpedit.msc
# Navigate to Computer Configuration → Windows Settings → Scripts → Shutdown
# You should see git-auto-push-shutdown.bat listed
```

### Check if script is copied:
```powershell
Test-Path "C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown\git-auto-push-shutdown.bat"
# Should return: True
```

### View shutdown script logs:
```powershell
# Check recent commits for "before shutdown" messages
cd z:\automation
git log --oneline --grep="shutdown" -10
```

---

## 🎭 Combining Both Approaches

**Recommended setup for maximum reliability:**

1. **Shutdown trigger** (this guide) - Runs before PC shuts down
2. **Daily trigger** (already installed) - Runs at 6 PM as backup

This ensures:
- ✅ Code is pushed every time you shut down
- ✅ Code is also pushed daily at 6 PM (if PC is on)
- ✅ Maximum reliability with dual triggers

Both tasks can coexist safely - they'll just skip if no changes are detected.

---

## 🗑️ Remove Shutdown Script

If you want to remove it later:

### Remove from Group Policy:
1. Open `gpedit.msc`
2. Navigate to: Computer Configuration → Windows Settings → Scripts → Shutdown
3. Select `git-auto-push-shutdown.bat`
4. Click **Remove** → **OK**
5. Run: `gpupdate /force`

### Delete the script file:
```powershell
Remove-Item "C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown\git-auto-push-shutdown.bat" -Force
```

---

## ⚠️ Important Notes

**Windows Home Users:**
- Group Policy Editor (`gpedit.msc`) is not available in Windows Home
- Use the Task Scheduler alternative method instead
- Or upgrade to Windows Pro/Enterprise

**Shutdown Delay:**
- Script is optimized to run in 1-3 seconds
- Won't significantly delay shutdown
- Max timeout: 5 seconds (then shutdown continues anyway)

**Network Required:**
- Push will fail silently if no network connection
- Changes stay committed locally
- Will sync on next run when network is available

**Credentials:**
- Must run `git-auto-push.bat` manually once first to save credentials
- Shutdown script reuses saved credentials
- No password prompts during shutdown

---

## 🆘 Troubleshooting

**Script doesn't run on shutdown:**
- Verify script is in the correct folder
- Check Group Policy configuration
- Run `gpupdate /force`
- Ensure script has correct path (z:\automation must exist)

**Shutdown takes too long:**
- Script runs silently in background
- Should complete in 1-3 seconds
- Check network connection speed

**Changes not pushed:**
- Check internet connection during shutdown
- Verify credentials are saved (run manual script once)
- Check git log: `git log --oneline -5` for commit messages

**Windows Home edition:**
- Use Task Scheduler logoff trigger instead
- Or manually run script before shutdown
- Consider upgrading to Windows Pro

---

## ✅ Verification Checklist

After setup, verify:
- [ ] Script copied to Group Policy folder
- [ ] Group Policy shutdown script configured
- [ ] Group Policy updated (`gpupdate /force`)
- [ ] Test run successful (`git-auto-push-shutdown.bat`)
- [ ] Git credentials saved (run `git-auto-push.bat` once)
- [ ] Daily task still active (optional backup)

**Ready to test?** Create a test file and shut down your PC - it should auto-push!
