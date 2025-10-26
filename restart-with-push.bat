@echo off
REM Run git auto-push, then restart

echo Running git auto-push before restart...
call "z:\automation\git-auto-push-shutdown.bat"

echo Restarting in 3 seconds...
timeout /t 3 /nobreak

shutdown /r /t 0
