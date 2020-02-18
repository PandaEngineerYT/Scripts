@echo off
REM ========================================
REM Script to fix Wi-Fi issues in Windows 10
REM ========================================
REM Schedule to run on event 1 for Log 'System' and Source 'Power-Troubleshooter' and run with highest privileges
REM Put 'cmd' as program and '/c start "" /min "<Full script path>"' as parameter
REM 
REM Go here for a video https://youtu.be/n5kyOazjPCo
REM 
set loop=0
:start
FOR /L %%G IN (1,1,9) DO (
Title %%G-%loop% 
ping 8.8.8.8 -n 1 | find "TTL=" && goto eof
ping 0.0.0.0 -n 2 -w 200 >nul
)
set /a loop=loop+1
Title Connecting...
REM List networks from lowest to highest priority
netsh wlan connect name="Android" ssid="Android"
netsh wlan connect name="My Wi-Fi" ssid="My Wi-Fi"
ping 0.0.0.0 -n 2 -w 200 >nul
ping 8.8.8.8 -n 1 | find "TTL=" && goto eof
Title Resetting...
net stop Wlansvc
net start Wlansvc
IF %loop% EQU 5 goto eof
goto :start
:eof
exit
