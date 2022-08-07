@echo off
cd .\configs\
:MENU
echo Select and installation method:
echo 1. DISH install
echo 2. Demo install
echo 3. Make my own config
set /p selection= enter number of your selection: 
IF %selection% EQU 1 GOTO :DISH
IF %selection% EQU 2 GOTO :DEMO
IF %selection% EQU 3 GOTO :CUSTOM
echo invalid selection, try again...
GOTO :MENU
:DISH
echo installing supported DISH config file...
echo config file not supported yet!!!
GOTO :MENU
:DEMO
echo installing Demo config file...
Start https://drive.google.com/u/0/uc?id=1XYm3a9kWeFrPdjTO8--gBt2LYG9tkW2F&export=download
echo move the config file to the configs folder!!!
pause
set index=0
:AnotherDEMOBOX
set /p serial=Enter the serial number of a box: 
set /p rcvr=Enter the receiver number of a box: 
echo devicesSerials[%index%]=%serial% >> demo.config
echo devicesReceiverNum[%index%]=%rcvr% >> demo.config
set /a "index+=1"
set /p another=Add another box from your rack/cube(y/N): 
if /i %another% EQU y GOTO :DONE
GOTO :AnotherDEMOBOX
:DONE
echo installation complete!
pause
exit
:CUSTOM
echo not supported yet...
GOTO :MENU

