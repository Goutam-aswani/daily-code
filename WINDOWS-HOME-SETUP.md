# Windows Home Edition - Shutdown with Auto-Push

Since Windows Home doesn't have Group Policy Editor, here's a simple alternative.

## 🎯 Solution: Use Shutdown Shortcuts

Instead of Windows' native shutdown button, use these shortcuts that auto-push first:

### Files Created:
- **`shutdown-with-push.bat`** - Pushes code, then shuts down
- **`restart-with-push.bat`** - Pushes code, then restarts

---

## 🚀 How to Use

### Method 1: Desktop Shortcuts (Recommended)

**Create shortcuts on your desktop:**

1. **For Shutdown:**
   - Right-click `shutdown-with-push.bat` → **Send to** → **Desktop (create shortcut)**
   - Right-click the desktop shortcut → **Properties**
   - Click **Change Icon** → Browse to: `%SystemRoot%\System32\SHELL32.dll`
   - Select the shutdown icon (red power button)
   - Click **OK**
   - Rename to: "Shutdown (Auto-Push)"

2. **For Restart:**
   - Right-click `restart-with-push.bat` → **Send to** → **Desktop (create shortcut)**
   - Change icon to restart/circular arrow icon
   - Rename to: "Restart (Auto-Push)"

**Now use these shortcuts instead of Windows shutdown button!**

---

### Method 2: Pin to Start Menu

1. Right-click `shutdown-with-push.bat`
2. Select **Pin to Start**
3. Repeat for `restart-with-push.bat`

---

### Method 3: Keyboard Shortcut

1. Right-click desktop shortcut → **Properties**
2. Click in **Shortcut key** field
3. Press: `Ctrl + Alt + S` (for Shutdown)
4. Click **OK**

Now `Ctrl + Alt + S` = auto-push + shutdown!

---

## 📋 Current Automation Status

| Method | Status | Details |
|--------|--------|---------|
| **Daily auto-push (6 PM)** | ✅ **ACTIVE** | Runs automatically every day |
| **Manual push** | ✅ **READY** | Run `.\git-auto-push.bat` anytime |
| **Shutdown auto-push** | 🔄 **Use shortcut** | Use `shutdown-with-push.bat` instead of Windows shutdown |

---

## 💡 Pro Tip: Make It Your Default Shutdown

**Option A:** Create a habit
- Always use the desktop shortcut to shut down
- Pin it to taskbar for easy access

**Option B:** PowerToys (optional)
- Install Microsoft PowerToys
- Use PowerToys Run (Alt+Space)
- Type "shutdown" → runs your script

**Option C:** AutoHotkey (advanced)
- Remap Windows shutdown button to your script
- Requires AutoHotkey installation

---

## ✅ Recommended Setup for Windows Home

**Keep it simple:**
1. ✅ **Daily task at 6 PM** - Already active (no action needed)
2. ✅ **Desktop shutdown shortcut** - Use instead of Windows shutdown (2 minutes)
3. ✅ **Manual script** - When you want to push immediately

This gives you full automation within Windows Home's limitations!

---

## 🎯 Summary

**Problem:** Windows Home doesn't have Group Policy (can't auto-run on shutdown)

**Solution:** Use shortcut scripts that push code THEN shut down

**Result:** Same outcome, just use the shortcut instead of Windows shutdown button

**Effort:** 2 minutes to create desktop shortcuts, then use them forever!

---

**Want the desktop shortcuts?** Right-click `shutdown-with-push.bat` → Send to → Desktop (create shortcut)
