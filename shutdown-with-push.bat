@echo off
REM Run git auto-push, then shutdown

echo Running git auto-push before shutdown...
call "z:\automation\git-auto-push-shutdown.bat"

echo Shutting down in 3 seconds...
timeout /t 3 /nobreak

shutdown /s /t 0
