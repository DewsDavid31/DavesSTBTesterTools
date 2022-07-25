@echo off
if not exist .\configs (mkdir .\configs
echo .\configs does not exist, make that folder and add a config file!
pause
exit
)
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
if not exist %VCS% mkdir %VCS%
echo Welcome to Dave's Current Production Version Updater!
set x=0
set y=0
:SymLoop1
if defined branches[%y%] (
call echo Updating branch %%branches[%y%]%%...
	set x=0
	:SymLoop2
	if defined devices[%x%] (
		call echo Updating %%devices[%x%]%% to VCS Current folder ...
		call set sub=%%devices[%x%]%%
		call set branch=%%branches[y]%%
		call set /A index=%numDevices% * %y% + %x%
		call set p=%%roots[%x%]%%\%%mappings[%index%]%%xx\
		GOTO :Search
		:Done
		call set /A x+=1
		GOTO :SymLoop2
	)
	call set /A y+=1
	GOTO :SymLoop1
)
exit

:Search
FOR /F "delims=" %%j IN ('dir "%p%\%a%" /b /ad-h /t:w /od') DO SET b=%%j
if not exist "%VCS%%sub%\%branch%\%b%" mkdir %VCS%%sub%\%branch%\%b%
set source=%p%\%b%
set target=%VCS%%sub%\%branch%\%b%
xcopy /s/e/i/d/Y %source% %target%
GOTO :Done


exit
