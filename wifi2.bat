cls
@echo off
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:checkPrivileges 
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges ) 

:getPrivileges 
if '%1'=='ELEV' (shift & goto gotPrivileges)  
ECHO. 
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation 
ECHO **************************************

setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs" 
ECHO UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs" 
"%temp%\OEgetPrivileges.vbs" 
exit /B 

:gotPrivileges 
::::::::::::::::::::::::::::
:START
::::::::::::::::::::::::::::
setlocal & pushd .

REM Run shell as admin (example) -
title Wifi hotspot by psyCHOder
cls
type lg.txt
:menu
goto menu
:stop
netsh wlan stop hostednetwork
echo Congrats your hotspot has been stopped
goto menu
:CO
echo Are you sure u want to stop wifi hotspot?(Y/N)
set/p "ch1o=>"
if %ch1o%==y goto stop
if %ch1o%==Y goto stop
if %ch1o%==n goto menu
if %ch1o%==N goto menu
echo Invalid choice.
goto CO

:start1
netsh wlan start hostednetwork
echo Congrats hotspot created! 
echo ssid and password is given in readme or see the menu please
goto menu
:CONFIRM
echo Are you sure u want to create wifi hotspot?(Y/N)
set/p "cho=>"
if %cho%==Y goto start1
if %cho%==y goto start1
if %cho%==n goto menu
if %cho%==N goto menu
echo Invalid choice.
goto CONFIRM
:htspt
echo Please enter the SSID you want to set forth
set/p "ssidname=>"
echo Please enter a password for your hotspot
set/p "password=>"
netsh wlan set hostednetwork mode=allow ssid=%ssidname% key=%password% keyUsage=persistent
goto CONFIRM

:menu
echo				***********************
echo 			*	Menu	      *
echo				***********************
echo 			1. Start
echo 			2. Stop
echo 			3. Access Point Details
echo				4. Developer
echo 			5. Exit
echo 			Enter Choice:
set/p "cho=>"
if %cho%==1 goto htspt
if %cho%==2 goto CO
if %cho%==3 start apd.txt
if %cho%==4 start developer.txt
if %cho%==5 goto end
cls

goto menu

:end
echo press any key to exit   
set/p "s=>"
