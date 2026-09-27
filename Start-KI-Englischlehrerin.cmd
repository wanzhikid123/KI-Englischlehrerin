@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Start-KI-Englischlehrerin.ps1" %*
if errorlevel 1 pause
