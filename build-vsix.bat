@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "PS_EXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"

if not exist "%PS_EXE%" (
  set "PS_EXE=powershell"
)

"%PS_EXE%" -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%build-vsix.ps1" %*
set "EXIT_CODE=%ERRORLEVEL%"

if not "%EXIT_CODE%"=="0" (
  echo.
  echo VSIX packaging failed with exit code %EXIT_CODE%.
  exit /b %EXIT_CODE%
)

echo.
echo VSIX packaging completed.
exit /b 0
