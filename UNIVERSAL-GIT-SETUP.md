# Universal Git Auto-Push for VS Code

This guide shows you how to set up git auto-push that works **across all your VS Code projects**, not just one folder.

---

## 🎯 Your Vision

**What you want:**
- Open any folder in VS Code
- Get prompted: "Connect to Git?"
- Choose: Create new repo / Connect existing / Skip
- Auto-push works for that folder automatically
- Each folder has its own Git settings

**Solution created!** ✅

---

## 🚀 Quick Setup (5 minutes)

### Step 1: Run the installer

```powershell
.\setup-universal-git.ps1
```

This will:
1. ✅ Add Git helper to your PowerShell profile
2. ✅ Configure VS Code settings
3. ✅ Optionally install VS Code extensions
4. ✅ Set up automatic Git detection

### Step 2: Restart your terminal

Close and reopen PowerShell (or VS Code terminal) for changes to take effect.

### Step 3: Test it!

In any folder (in VS Code terminal):
```powershell
Check-GitSetup
```

You'll see a menu like this:
```
📁 This folder is not a Git repository

Would you like to set up Git for this folder?

  [1] Initialize new Git repo + GitHub
  [2] Connect to existing GitHub repo
  [3] Initialize Git only (local)
  [4] Skip (don't ask again for this session)

Enter choice (1-4):
```

**Done!** Now this works in **any folder** you open!

---

## ⌨️ How to Use

### When you open a new folder in VS Code:

1. **Open integrated terminal** (Ctrl + `)
2. **Type:** `Check-GitSetup`
3. **Choose your option:**
   - **Option 1:** Create new GitHub repo (guides you through setup)
   - **Option 2:** Connect to existing GitHub repo
   - **Option 3:** Local Git only (no GitHub)
   - **Option 4:** Skip for now

### The helper will ask you:

- ✅ Your GitHub username (e.g., `Goutam-aswani`)
- ✅ Your email (e.g., `goutamaswani43@gmail.com`)
- ✅ GitHub repo URL (e.g., `https://github.com/username/project.git`)
- ✅ Auto-push preference (daily/manual/on-save)

### Result:

Each folder gets its own:
- ✅ Git configuration (user/email can be different per project)
- ✅ GitHub remote (different repo per folder)
- ✅ Auto-push settings (if you enable them)

---

## 🎯 Features

### ✅ Works Everywhere
- Any folder you open in VS Code
- Different repos per folder
- Different user settings per project

### ✅ Interactive Setup
- Menu-driven prompts
- Guides you through Git initialization
- Offers to push to GitHub immediately

### ✅ Flexible Options
1. **New repo:** Initialize Git + create GitHub repo
2. **Existing repo:** Clone or connect to existing
3. **Local only:** Git without GitHub
4. **Skip:** Don't set up Git

### ✅ Auto-Push Options
- Daily scheduled task (per folder)
- On file save (VS Code extension)
- Manual only

---

## 📋 Available Commands

After setup, use these commands in any VS Code terminal:

### `Check-GitSetup`
Main command - checks current folder and offers Git setup

### Example workflows:

**New project:**
```powershell
# Navigate to your project
cd C:\Users\YourName\Projects\my-new-project

# Open in VS Code
code .

# In VS Code terminal:
Check-GitSetup
# Choose option 1: Initialize new Git repo + GitHub
```

**Existing GitHub repo:**
```powershell
cd C:\Users\YourName\Projects\existing-project
code .

# In VS Code terminal:
Check-GitSetup
# Choose option 2: Connect to existing GitHub repo
```

---

## 🛠️ Advanced: Auto-Detection on Folder Open

Want the prompt to appear **automatically** when you open a folder?

Edit your PowerShell profile:
```powershell
notepad $PROFILE
```

Find this line (around line 240):
```powershell
# Uncomment next line to enable auto-check on directory change
# Check-GitSetup
```

Remove the `#` to enable:
```powershell
Check-GitSetup
```

Now it auto-checks every folder!

---

## 🎨 VS Code Extensions (Optional)

For even better Git integration, install:

### GitLens (Highly Recommended)
```powershell
code --install-extension eamodio.gitlens
```

Features:
- Visual Git history
- Blame annotations
- One-click push/pull

### Git Graph
```powershell
code --install-extension mhutchie.git-graph
```

Features:
- Visual commit graph
- Branch visualization

### GitHub Pull Requests
```powershell
code --install-extension GitHub.vscode-pull-request-github
```

Features:
- Create PRs from VS Code
- Review code inline

---

## � Files Created

- **`GitAutoSetup.psm1`** - PowerShell module with Git helpers
- **`setup-universal-git.ps1`** - One-click installer
- **`vscode-settings-template.json`** - VS Code settings template
- **`UNIVERSAL-GIT-SETUP.md`** - This guide

---

## 🔧 Customization

### Different Git user per folder?

The helper asks for username/email every time, so each folder can have:
- Different GitHub account
- Different email address
- Different remote repository

### Global Git settings

To set global defaults (used as fallback):
```powershell
git config --global user.name "Goutam-aswani"
git config --global user.email "goutamaswani43@gmail.com"
```

### Per-folder Git settings

The helper sets these per folder automatically:
```powershell
# Inside each project folder
git config user.name "ProjectSpecificUser"
git config user.email "project@example.com"
```

---

## ✅ Example Workflow

**Scenario:** You start a new project in a different folder

```powershell
# Create and navigate to new project
mkdir C:\Projects\awesome-app
cd C:\Projects\awesome-app

# Open in VS Code
code .

# In VS Code terminal (Ctrl + `):
Check-GitSetup

# Follow the prompts:
# → Choose [1] Initialize new Git repo + GitHub
# → Username: Goutam-aswani
# → Email: goutamaswani43@gmail.com
# → Repo URL: https://github.com/Goutam-aswani/awesome-app.git
# → Auto-push: [1] Daily at 6 PM

# Done! Git is set up for this folder
# Work on your code...
# Commits/pushes work independently of other folders
```

---

## 🆘 Troubleshooting

**Command not found: Check-GitSetup**
- Restart your terminal
- Run: `Import-Module GitAutoSetup -DisableNameChecking`
- Check: `$PROFILE` file has the import line

**VS Code extensions not installing**
- Ensure `code` command is in PATH
- Install manually from VS Code extensions marketplace

**Different repos conflicting**
- Each folder is independent
- Check which folder you're in: `pwd`
- Check remote: `git remote -v`

---

## 🎉 Summary

**Before:** Only `z:\automation` had auto-push

**After:** **Every folder** can have:
- ✅ Its own Git configuration
- ✅ Its own GitHub repository
- ✅ Its own auto-push settings
- ✅ Quick setup with `Check-GitSetup`

**Your vision:** ✅ Achieved!

Now you can work in any folder, get prompted for Git setup, and have independent auto-push per project!

---

**Ready to set it up?** Run:
```powershell
.\setup-universal-git.ps1
```
