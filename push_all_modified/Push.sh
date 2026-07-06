@echo off
setlocal EnableDelayedExpansion

cd /d "%~dp0"

if "%~1"=="" goto :show_usage
if not exist "%~1\" goto :show_usage_invalid

set "SRC_ROOT=%~f1"
if "%SRC_ROOT:~-1%"=="\" set "SRC_ROOT=%SRC_ROOT:~0,-1%"

set "MINUTES=%~2"
if "%MINUTES%"=="" (
    set "MINUTES=60"
    goto :minutes_ok
)

echo %MINUTES%| findstr /r "^[1-9][0-9]*$" >nul
if errorlevel 1 (
    echo [WARN] Invalid minutes "%MINUTES%", use default 60 minutes.
    set "MINUTES=60"
)
:minutes_ok

set "DIR_OK=1"

if not exist "%SRC_ROOT%\vendor\lib64\" (
    echo [ERROR] vendor\lib64 not found under source root.
    set "DIR_OK=0"
)
if not exist "%SRC_ROOT%\vendor\bin\" (
    echo [ERROR] vendor\bin not found under source root.
    set "DIR_OK=0"
)
if not exist "%SRC_ROOT%\odm\lib64\" (
    echo [ERROR] odm\lib64 not found under source root.
    set "DIR_OK=0"
)
if not exist "%SRC_ROOT%\odm\bin\" (
    echo [ERROR] odm\bin not found under source root.
    set "DIR_OK=0"
)

if "!DIR_OK!"=="0" (
    echo.
    echo Directory structure check failed. Exit.
    pause
    exit /b 1
)

echo.
echo ========================================
echo Source root : %SRC_ROOT%
echo Time window : files modified in last !MINUTES! minute(s)
echo Working dir : %CD%
echo ========================================
echo.

echo [STEP] adb wait-for-device
adb wait-for-device

echo [STEP] adb root
adb root

echo [STEP] adb remount
adb remount

echo.
echo [STEP] Scan and push recently modified files...
echo.

set "PUSH_COUNT=0"
set "PUSH_FAIL=0"

for /f "usebackq delims=" %%F in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "$root = $env:SRC_ROOT; $minutes = [int]$env:MINUTES; $cutoff = (Get-Date).AddMinutes(-$minutes); $scanDirs = @('vendor\lib64', 'vendor\bin', 'odm\lib64', 'odm\bin'); foreach ($rel in $scanDirs) { $dir = Join-Path $root $rel; if (-not (Test-Path -LiteralPath $dir)) { continue }; Get-ChildItem -LiteralPath $dir -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -ge $cutoff } | ForEach-Object { $relDir = $_.DirectoryName.Substring($root.Length).TrimStart('\'); $remote = '/' + ($relDir -replace '\\', '/'); if (-not $remote.EndsWith('/')) { $remote += '/' }; Write-Output ($_.FullName + '|' + $remote) } }"`) do (
    for /f "tokens=1,2 delims=|" %%A in ("%%F") do (
        echo [PUSH] "%%A" --^> "%%B"
        adb push "%%A" "%%B"
        if errorlevel 1 (
            set /a PUSH_FAIL+=1
            echo [FAIL] "%%A"
        ) else (
            set /a PUSH_COUNT+=1
            echo [OK] "%%A"
        )
        echo.
    )
)

echo ========================================
echo Done. Success: !PUSH_COUNT!  Failed: !PUSH_FAIL!
echo ========================================
echo.
pause
exit /b 0

:show_usage
echo.
echo Usage:
echo   Push_all_new.bat ^<source_root^> [minutes]
echo.
echo   source_root  Root with vendor\lib64 vendor\bin odm\lib64 odm\bin
echo   minutes      Push files modified in last N minutes (default: 60)
echo.
echo Example:
echo   Push_all_new.bat X:\workspace\TAPS_x6878_feature\out\target\product\volcano 30
echo.
pause
exit /b 1

:show_usage_invalid
echo.
echo [ERROR] Invalid path: "%~1"
echo.
goto :show_usage
