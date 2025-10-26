# Git Auto-Push Keyboard Shortcuts - Setup Complete!

I've created TWO methods for keyboard shortcuts. Choose the one you prefer:

---

## ✅ Method 1: Windows Built-in (Simplest - No Install)

**Quick 2-minute setup:**

### Step 1: Create Desktop Shortcuts

Run these commands in PowerShell:

```powershell
# Create desktop shortcuts
$WshShell = New-Object -ComObject WScript.Shell

# Shutdown shortcut
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Git Push + Shutdown.lnk")
$Shortcut.TargetPath = "z:\automation\shutdown-with-push.bat"
$Shortcut.WorkingDirectory = "z:\automation"
$Shortcut.Save()

# Restart shortcut
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Git Push + Restart.lnk")
$Shortcut.TargetPath = "z:\automation\restart-with-push.bat"
$Shortcut.WorkingDirectory = "z:\automation"
$Shortcut.Save()

# Manual push shortcut
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Git Push.lnk")
$Shortcut.TargetPath = "z:\automation\git-auto-push.bat"
$Shortcut.WorkingDirectory = "z:\automation"
$Shortcut.Save()

Write-Host "Desktop shortcuts created!" -ForegroundColor Green
```

### Step 2: Assign Keyboard Shortcuts

For each desktop shortcut:
1. **Right-click** → **Properties**
2. Click in **Shortcut key** field
3. Press your desired key combo:
   - **Shutdown**: Ctrl + Alt + S
   - **Restart**: Ctrl + Alt + R
   - **Manual Push**: Ctrl + Alt + P
4. Click **OK**

**Done!** Press the keys anywhere to run scripts.

---

## 🚀 Method 2: AutoHotkey (Advanced - More Features)

**Includes notifications, confirmations, and system tray menu!**

### Step 1: Install AutoHotkey

```powershell
# Install AutoHotkey using winget
winget install --id Lexikos.AutoHotkey
```

Or download manually: https://www.autohotkey.com/

### Step 2: Run the Script

**Double-click:** `git-auto-push-hotkeys.ahk`

You'll see a green "H" icon in your system tray!

### Step 3: (Optional) Auto-start on Windows Boot

```powershell
# Copy script to Startup folder
$StartupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
Copy-Item "z:\automation\git-auto-push-hotkeys.ahk" -Destination $StartupFolder

Write-Host "AutoHotkey script will now start automatically on boot!" -ForegroundColor Green
```

---

## ⌨️ Your Keyboard Shortcuts

| Shortcut | Action | Method |
|----------|--------|--------|
| **Ctrl + Alt + S** | Push + Shutdown | Both methods |
| **Ctrl + Alt + R** | Push + Restart | Both methods |
| **Ctrl + Alt + P** | Push only (shows window) | Both methods |
| **Ctrl + Alt + Q** | Quick silent push + notification | AutoHotkey only |

---

## 🎨 AutoHotkey Features (Method 2)

When you run the AutoHotkey script, you get:

✅ **System tray icon** - Right-click for menu  
✅ **Toast notifications** - Shows when pushing  
✅ **Confirmation prompts** - Prevents accidental shutdown  
✅ **Silent quick push** - Ctrl+Alt+Q with no window  
✅ **Tray menu** - Click icon to run commands  

---

## 📋 Quick Start Commands

### Create Desktop Shortcuts (Method 1):
```powershell
# Run this entire block in PowerShell
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Git Push + Shutdown.lnk")
$Shortcut.TargetPath = "z:\automation\shutdown-with-push.bat"
$Shortcut.WorkingDirectory = "z:\automation"
$Shortcut.Save()

Write-Host "Shortcut created! Now right-click it → Properties → Set Shortcut key to Ctrl+Alt+S"
```

### Install AutoHotkey (Method 2):
```powershell
winget install --id Lexikos.AutoHotkey
```

Then double-click `git-auto-push-hotkeys.ahk`

---

## 🎯 My Recommendation

**Start with Method 1** (Windows built-in):
- ✅ No installation needed
- ✅ Works immediately
- ✅ Simple and reliable

**Upgrade to Method 2** if you want:
- ✅ Toast notifications
- ✅ System tray menu
- ✅ Silent quick push
- ✅ Auto-start on boot

---

## 🧪 Testing Your Shortcuts

**After setup, test each shortcut:**

1. Press **Ctrl + Alt + P** → Should open git-auto-push window
2. Press **Ctrl + Alt + S** → Should ask to shutdown (cancel if testing)
3. Press **Ctrl + Alt + R** → Should ask to restart (cancel if testing)
4. **(AutoHotkey only)** Press **Ctrl + Alt + Q** → Should show notification

---

## 🔧 Customization

**Want different keyboard shortcuts?**

**Method 1 (Windows):**
- Right-click desktop shortcut → Properties → Change Shortcut key

**Method 2 (AutoHotkey):**
- Edit `git-auto-push-hotkeys.ahk` in Notepad
- Change the key combos (e.g., `^!s` = Ctrl+Alt+S)
- Save and restart the script

**AutoHotkey Key Reference:**
- `^` = Ctrl
- `!` = Alt  
- `+` = Shift
- `#` = Win key

Examples:
- `^!s` = Ctrl + Alt + S
- `#+p` = Win + Shift + P
- `F12` = F12 key

---

## 📁 Files Created

- ✅ `KEYBOARD-SHORTCUTS.md` - This guide
- ✅ `git-auto-push-hotkeys.ahk` - AutoHotkey script with shortcuts
- ✅ Desktop shortcuts - (you create these)

---

## ✅ Setup Checklist

**Method 1 (Simple):**
- [ ] Create 3 desktop shortcuts (run PowerShell commands above)
- [ ] Assign keyboard shortcuts in Properties
- [ ] Test shortcuts
- [ ] ✅ Done!

**Method 2 (Advanced):**
- [ ] Install AutoHotkey (`winget install --id Lexikos.AutoHotkey`)
- [ ] Double-click `git-auto-push-hotkeys.ahk`
- [ ] Test shortcuts
- [ ] (Optional) Copy to Startup folder for auto-start
- [ ] ✅ Done!

---

## 🎉 You're All Set!

Pick your method and you'll have keyboard shortcuts in 2 minutes!

**Quick recommendation:** Start with Method 1 (no install), then upgrade to Method 2 later if you want more features.

Want me to help you set it up now?
