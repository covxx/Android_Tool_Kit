@Echo off

 :MENU
 CLS
ECHO WELCOME TO COVXX'S TOOLKIT (Alpha 5)
ECHO =========================================
ECHO Using this tool at your own risk
ECHO Any issues please report in the forum
ECHO Remeber to give thanks if this helped
ECHO = = = = = = = = = = = = = = == = = = == =
ECHO This is in active development 
ECHO Alpha 6-10/16
ECHO
ECHO  (~:
ECHO =========================================
ECHO 1. ADB stuff
ECHO 2. 
ECHO 3. nothing yet..
ECHO 4. vzw gs4 stuff
ECHO 5. EXIT 
ECHO.
SET INPUT=
SET /P INPUT=SELECT NUMBER OF OPTION:  

IF /I '%INPUT%'=='1' GOTO sl
IF /I '%INPUT%'=='2' GOTO rb
IF /I '%INPUT%'=='3' GOTO 
IF /I '%INPUT%'=='4' GOTO GS4
IF /I '%INPUT%'=='5' GOTO QUIT

 :GS4 
cls
cd devices\GS4\rootmdk\
ECHO This stuff will only work for galaxy s4 on verizon on VRUAMDK build
ECHO For now...
ECHO =============================
ECHO 1.Start root - after pre- release kernel is flashed-
ECHO 2.How to root
ECHO 3.Maybe more later?
ECHO 4.Go back to main menu
ECHO.
SET INPUT=
SET /P INPUT=SELECT NUMBER OF OPTION:  

IF /I '%INPUT%'=='1' GOTO S4ROOTVZW
IF /I '%INPUT%'=='2' GOTO hwtorot
IF /I '%INPUT%'=='3' GOTO 
IF /I '%INPUT%'=='4' GOTO MENU
IF /I '%INPUT%'=='5' GOTO QUIT

 :S4ROOTVZW
cls
ECHO =====================================
ECHO =Thanks to Dan Rosenberg (@djrbliss)=
ECHO.
ECHO =This motochopper - not made by me at all=
ECHO.
ECHO =This can break your phone,if you do not my fault=
ECHO.
ECHO =Or Dans=
ECHO.
ECHO =Or anyone other then you=
ECHO.
ECHO =Enjoy root though (~:=
ECHO.
ECHO =Press enter to root your phone...=
ECHO ===================================
pause

ECHO.

adb kill-server

ECHO Waiting for device...
adb wait-for-device

ECHO Device found.

ECHO Pushing exploit...
adb push pwn /data/local/tmp/
adb shell chmod 755 /data/local/tmp/pwn

ECHO Pushing root tools...
adb push su /data/local/tmp/
adb push busybox /data/local/tmp/
adb install Superuser.apk

ECHO Rooting phone...
adb shell /data/local/tmp/pwn

ECHO Cleaning up...
adb shell rm /data/local/tmp/pwn
adb shell rm /data/local/tmp/su
adb shell rm /data/local/tmp/busybox

ECHO Exploit complete. Press enter to reboot
pause
adb reboot
adb kill-server

ECHO now flash the stock kernel
ECHO opening odin..
ECHO .
\tools\odin\odin3.exe
GOTO MENU


 :sd
cls
ECHO Are you ready to sideload?
ECHO Remeber to make surey the package name is 'update.zip'
ECHO Or this wont work
ECHO When you're ready hit enter
ECHO. 
pause
adb sideload toolkit\update.zip


