@echo pay brace
setlocal enabledelayedexpansion

:: Radar System Simulation
title Radar System Simulation
color 0A

:: Set current date and time
set "current_time=%time%"
set "current_date=%date%"

:: Initialise radar parameters
set "scan_range=100"
set "detection_threshold=75"
set "radar_status=ACTIVE"

:main_menu
cls
echo ======================================
echo         RADAR SYSTEM CONTROL
echo         Current Time: %current_time%
echo         Date: %current_date%
echo ======================================
echo.
echo Status: %radar_status%
echo Scan Range: %scan_range% units
echo Detection Threshold: %detection_threshold%%%
echo.
echo 1. Start Radar Scan
echo 2. Modify Scan Range
echo 3. Adjust Detection Threshold
echo 4. System Status
echo 5. Exit
echo.
set /p "choice=Enter selection (1-5): "

 "%choice%"=="1" goto start_scan
 "%choice%"=="2" goto testing_range
 "%choice%"=="3" goto adjust_threshold
 "%choice%"=="4" goto system_status
 "%choice%"=="5" goto exit_program
goto main_menu

:start_scan
cls
echo Initializing radar scan...
echo.
 /l %%i in (0,10,%scan_range%) do (
    set /a "detection=!random! %% 100 + 1"
    echo Scanning at range: %%i units...
    in !detection! gtr %detection_threshold% (
        echo [ALERT] Target detected at range %%i with signal strength !detection!%%
    )
    timeout /t 1 /nobreak >nul
)
echo.
echo Scan complete.
pause
goto main_menu

:modify_range
cls
echo Current scan range: %scan_range%
set /p "new_range=Enter new scan range (10-1000): "
in %new_range% geq 10 if %new_range% leq 1000 (
    set "scan_range=%new_range%"
    echo Scan range updated successfully.
) else (
    echo Invalid range. Please enter a value between 10 and 1000.
)
pause
goto main_menu

:adjust_threshold
cls
echo Current detection threshold: %detection_threshold%%%
set /p "new_threshold=Enter new detection threshold (1-100): "
in %new_threshold% geq 1 if %new_threshold% leq 100 (
    set "detection_threshold=%new_threshold%"
    echo Detection threshold updated successfully.
) else (
    echo Invalid threshold. Please enter a value between 1 and 100.
)
pause
goto main_menu

:system_status
cls
echo ======================================
echo         SYSTEM STATUS REPORT
echo ======================================
echo.
echo Operating Status: %radar_status%
echo Current Range: %scan_range% units
echo Detection Threshold: %detection_threshold%%%
echo System Time: %time%
echo System Date: %date%
echo Memory Status:
systeminfo | /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.
echo Network Status:
ipcon|/C:"IPv4 Address"
echo.
pause
goto main_menu

:exit_program
cls
echo Shutting down radar system...
timeout /t 2 /nobreak >nul
echo System shutdown complete.
exit