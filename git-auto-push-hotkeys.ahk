; Git Auto-Push Keyboard Shortcuts
; AutoHotkey Script
; 
; Keyboard Shortcuts:
;   Ctrl + Alt + S  = Push code + Shutdown
;   Ctrl + Alt + R  = Push code + Restart
;   Ctrl + Alt + P  = Push code only (manual)
;   Ctrl + Alt + Q  = Quick silent push with notification
;
; Installation:
;   1. Install AutoHotkey from https://www.autohotkey.com/
;   2. Double-click this file to run it
;   3. (Optional) Add to Windows Startup folder to run on boot

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Configuration
global REPO_PATH := "z:\automation"
global SHUTDOWN_SCRIPT := "shutdown-with-push.bat"
global RESTART_SCRIPT := "restart-with-push.bat"
global PUSH_SCRIPT := "git-auto-push.bat"

; ========================================
; Ctrl + Alt + S = Push + Shutdown
; ========================================
^!s::
{
    MsgBox, 4, Git Auto-Push, Push code and shutdown?`n`nPress Yes to continue.
    IfMsgBox Yes
    {
        TrayTip, Git Auto-Push, Pushing to GitHub and shutting down..., 3, 1
        RunWait, %REPO_PATH%\%SHUTDOWN_SCRIPT%, %REPO_PATH%
    }
    return
}

; ========================================
; Ctrl + Alt + R = Push + Restart
; ========================================
^!r::
{
    MsgBox, 4, Git Auto-Push, Push code and restart?`n`nPress Yes to continue.
    IfMsgBox Yes
    {
        TrayTip, Git Auto-Push, Pushing to GitHub and restarting..., 3, 1
        RunWait, %REPO_PATH%\%RESTART_SCRIPT%, %REPO_PATH%
    }
    return
}

; ========================================
; Ctrl + Alt + P = Push only (manual)
; ========================================
^!p::
{
    TrayTip, Git Auto-Push, Pushing to GitHub..., 2, 1
    Run, %REPO_PATH%\%PUSH_SCRIPT%, %REPO_PATH%
    return
}

; ========================================
; Ctrl + Alt + Q = Quick silent push
; ========================================
^!q::
{
    TrayTip, Git Auto-Push, Quick push started..., 1, 1
    RunWait, %REPO_PATH%\git-auto-push-shutdown.bat, %REPO_PATH%, Hide
    Sleep, 1000
    TrayTip, Git Auto-Push, Code pushed to GitHub!, 2, 1
    return
}

; ========================================
; Tray menu customization
; ========================================
Menu, Tray, Tip, Git Auto-Push Shortcuts Active
Menu, Tray, NoStandard
Menu, Tray, Add, Push to GitHub (Ctrl+Alt+P), ManualPush
Menu, Tray, Add
Menu, Tray, Add, Shutdown with Push (Ctrl+Alt+S), ShutdownWithPush
Menu, Tray, Add, Restart with Push (Ctrl+Alt+R), RestartWithPush
Menu, Tray, Add
Menu, Tray, Add, Quick Push (Ctrl+Alt+Q), QuickPush
Menu, Tray, Add
Menu, Tray, Add, Open Automation Folder, OpenFolder
Menu, Tray, Add
Menu, Tray, Add, Exit, ExitScript
return

; ========================================
; Tray menu handlers
; ========================================
ManualPush:
    TrayTip, Git Auto-Push, Pushing to GitHub..., 2, 1
    Run, %REPO_PATH%\%PUSH_SCRIPT%, %REPO_PATH%
    return

ShutdownWithPush:
    MsgBox, 4, Git Auto-Push, Push code and shutdown?
    IfMsgBox Yes
    {
        TrayTip, Git Auto-Push, Pushing and shutting down..., 3, 1
        RunWait, %REPO_PATH%\%SHUTDOWN_SCRIPT%, %REPO_PATH%
    }
    return

RestartWithPush:
    MsgBox, 4, Git Auto-Push, Push code and restart?
    IfMsgBox Yes
    {
        TrayTip, Git Auto-Push, Pushing and restarting..., 3, 1
        RunWait, %REPO_PATH%\%RESTART_SCRIPT%, %REPO_PATH%
    }
    return

QuickPush:
    TrayTip, Git Auto-Push, Quick push started..., 1, 1
    RunWait, %REPO_PATH%\git-auto-push-shutdown.bat, %REPO_PATH%, Hide
    Sleep, 1000
    TrayTip, Git Auto-Push, Code pushed to GitHub!, 2, 1
    return

OpenFolder:
    Run, explorer.exe %REPO_PATH%
    return

ExitScript:
    ExitApp
    return
