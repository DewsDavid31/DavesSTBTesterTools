@echo off
if not exist .\configs (mkdir .\configs
echo .\configs does not exist, make that folder and add a config file!
pause
exit
)
set d=0
set x=0
set r=0
set k=0
set b=0
:configAgain
echo config files:
FOR /F "tokens=*" %%j in ('DIR .\configs /b w*') DO (
		ECHO %%j
)
set /p config= Type a config you wish to use: 
if not exist .\configs\%config% (echo invalid config file try again...
GOTO :configAgain
)

for /f "delims=" %%x in ('findstr /v /c:"//" .\configs\%config%') do (set "%%x")
set /a "maxDev=numDevices"
if not exist %VCS% mkdir %VCS%
echo Welcome to Dave's Current Production Version Updater!
:SymLoop1	
if defined mappings[%k%] (
	call echo Updating %%devices[%d%]%% to VCS Current folder ...
	call set p=%%roots[%d%]%%%%mappings[%k%]%%xx\
	call set branch=%%branches[%r%]%%
	call set sub=%%devices[%d%]%%
	set /a "k+=1"
	set /a "d+=1"
	if %d%==%maxDev% (set d=0
	set /a "r+=1"
 )
	GOTO :Search
	:Done
	GOTO SymLoop1
)
pause
exit
:Search
set b=
FOR /F "delims=" %%a IN ('dir "%p%" /b /ad-h /t:w /od') DO SET b=%%a
echo most recent %branch% software for %sub% is: %b%
if not exist "%VCS%%sub%\%branch%\%b%" mkdir %VCS%%sub%\%branch%\%b%
set source=%p%\%b%
set target=%VCS%%sub%\%branch%\%b%
xcopy /s/e/i/d/Y %source% %target%
GOTO :Done
exit
