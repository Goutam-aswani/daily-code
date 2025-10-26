# Keyboard Shortcuts for Git Auto-Push Scripts

This guide shows you how to create keyboard shortcuts to run the auto-push scripts directly.

---

## 🎯 Method 1: Windows Built-in Shortcuts (Easiest)

**Create desktop shortcuts with keyboard hotkeys:**

### Step 1: Create Desktop Shortcuts

1. **Right-click** `shutdown-with-push.bat` → **Send to** → **Desktop (create shortcut)**
2. **Right-click** `restart-with-push.bat` → **Send to** → **Desktop (create shortcut)**
3. **Right-click** `git-auto-push.bat` → **Send to** → **Desktop (create shortcut)**

### Step 2: Assign Keyboard Shortcuts

**For Shutdown:**
1. Right-click desktop shortcut → **Properties**
2. Click in **Shortcut key** field
3. Press: **Ctrl + Alt + S** (or any key combo you want)
4. Click **OK**

**For Restart:**
1. Right-click desktop shortcut → **Properties**
2. Shortcut key: **Ctrl + Alt + R**
3. Click **OK**

**For Manual Push:**
1. Right-click desktop shortcut → **Properties**
2. Shortcut key: **Ctrl + Alt + P**
3. Click **OK**

### Step 3: Test It!

- Press **Ctrl + Alt + S** → Auto-push + Shutdown
- Press **Ctrl + Alt + R** → Auto-push + Restart
- Press **Ctrl + Alt + P** → Manual push (no shutdown)

**Done!** Works system-wide from anywhere.

---

## 🚀 Method 2: AutoHotkey Script (Most Powerful)

**For advanced users who want more control:**

### Install AutoHotkey

```powershell
# Install using winget
winget install --id Lexikos.AutoHotkey
```

Or download from: https://www.autohotkey.com/

### Use the AutoHotkey Script

I'll create an AutoHotkey script for you with these shortcuts:
- **Ctrl + Alt + S** → Shutdown with push
- **Ctrl + Alt + R** → Restart with push
- **Ctrl + Alt + P** → Manual push only
- **Ctrl + Alt + Q** → Quick push (shows notification)

---

## 📋 Recommended Keyboard Shortcuts

| Shortcut | Action | Description |
|----------|--------|-------------|
| **Ctrl + Alt + S** | Shutdown | Push code + shutdown |
| **Ctrl + Alt + R** | Restart | Push code + restart |
| **Ctrl + Alt + P** | Push only | Push code (no shutdown) |
| **Ctrl + Alt + Q** | Quick push | Push + show notification |

Feel free to change these to whatever you prefer!

---

## ⚙️ Customization Tips

**Don't like Ctrl + Alt + S?** Change it to:
- **Ctrl + Shift + S**
- **Win + S**
- **F12**
- Any combination you want!

Just change it in the shortcut properties.

---

## ⚠️ Important Notes

**Keyboard shortcuts require:**
- Desktop shortcuts must stay on desktop (don't delete them)
- You can hide them in a folder if desktop looks cluttered
- Shortcuts work even when the folder is in a subfolder

**If shortcut stops working:**
- Check if desktop shortcut still exists
- Recreate the keyboard shortcut in Properties
- Restart Windows Explorer (Task Manager → Restart explorer.exe)

---

## 🎨 Optional: Clean Up Desktop

**Hide shortcuts but keep keyboard shortcuts working:**

1. Create folder: `C:\Users\YourName\Shortcuts`
2. Move all three desktop shortcuts into this folder
3. Keyboard shortcuts still work!

Or pin shortcuts to Start Menu instead of desktop.

---

## 🆘 Troubleshooting

**Keyboard shortcut not working:**
- Desktop shortcut was deleted → Recreate it
- Conflicting shortcut → Choose different key combo
- Need to restart Explorer → Task Manager → Restart explorer.exe

**Shortcut opens command window:**
- Normal behavior - it will close automatically
- Want silent? Use the AutoHotkey method instead

---

Want me to create the AutoHotkey script for you with even more features (silent execution, notifications, etc.)?
