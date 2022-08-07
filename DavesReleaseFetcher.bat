@echo off
if not exist .\configs (mkdir .\configs
echo .\configs does not exist, make that folder and add a config file!
pause
exit
)
:configAgain
echo your config files:
FOR /F "tokens=*" %%j in ('DIR .\configs /b w*') DO (
		ECHO * %%j
                ECHO *
)
set /p config= Type the name of your rack/cubes .config file from above to use: 
if not exist .\configs\%config% (echo invalid config file try again...
GOTO :configAgain
)

for /f "delims=" %%x in ('findstr /v /c:"//" .\configs\%config%') do (set "%%x")
set /a "maxDev=numDevices-1"
if not exist %VCS% mkdir %VCS%
echo Welcome to Dave's Production Version Fetcher!
:Menu
set y=0
set k=0
set z=0
set q=0
set x=0
set w=0
echo 1: Fetch Release for a Whole Cube/Rack
echo 2: Fetch a Single Release
echo 3: Fetch an Exotic Release(no known intent, but known software name) 
echo 4: Show me every current release version
echo 5: Exit
set /p option= Pick an option:
if %option% EQU 5 exit
if %option% EQU 4 GOTO :Show
if %option% EQU 3 GOTO :Exotic
if %option% EQU 2 GOTO :Single
if %option% EQU 1 GOTO :Cube
GOTO :Menu


:Show
set m=0
set d=0
set x=0
set r=0
set k=0
set b=0
set index=0
:SymLoop7	
if defined mappings[%k%] (

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
	GOTO SymLoop7
)
pause
GOTO :Menu

:Search
set b=
FOR /F "delims=" %%a IN ('dir "%p%" /b /ad-h /t:w /od') DO SET b=%%a
echo most recent %branch% software for %sub% is: %b%

GOTO :Done
pause
exit


:Exotic
echo Pick a Model:
:SymLoop1
	if defined devices[%x%] (
		call echo %x%: %%devices[%x%]%%
		set /a "x+=1"
		GOTO :SymLoop1
	)
call set /p model_id= Selection:
call set model=%%devices[%model_id%]%%
set /p family= Enter a software family(with xs included):
set /p version= Enter a software name:
call set root= %%roots[%model_id%]%%
set next= %root%\%family%\%version%
call set DLCart[%y%]= %%next%%
set /a "y+=1"
set /p c= done with download cart(y/N)?: 
if %c%==y (GOTO :CopyLoop1)
GOTO :Another
:CopyLoop1
echo Copying Download Cart to VCS...
	if defined DLCart[%z%] (
		call xcopy /s/e/i/d/Y %%DLCart[%z%]%% %VCS%%model%\%family%\%version%
		call echo copying %%DLCart[%z%]%% to %VCS%%model%\%family%\%version%
		set /a "z+=1"
		GOTO :CopyLoop1
	)
pause
GOTO :Menu

:Cube
set w=0
set x=0
set z=0
set q=0
set root='none'
echo Pick a Branch for all devices:
:SymLoop2
	if defined branches[%w%] (
		call echo %w%: %%branches[%w%]%%
		set /a "w+=1"
		GOTO :SymLoop2
	)
call set /p branch_id= Selection:
call set branch=%%branches[%branch_id%]%%
set /p version= Type in version to checkout for all devices(example: C1 of PGC1):
set /a "index=numDevices*branch_id"
setlocal ENABLEDELAYEDEXPANSION
:SymLoop4
if defined roots[%z%] (
	call set root=%%roots[%z%]%%%%mappings[%index%]%%xx\%%mappings[%index%]%%
        call set rootTarget=%%devices[%z%]%%\%%branches[%branch_id%]%%\%%mappings[%index%]%%
	call set next=!root!%version%
        call set nextTarget=!rootTarget!%version%
	call set DLCart[%z%]=%%next%%
        call set DLTarget[%z%]=%%nextTarget%%
	set /a "z+=1"
	set /a "index+=1"    
        GOTO :SymLoop4
)
:CopyLoop2
echo Copying Download Cart to VCS...
	if defined DLCart[%q%] (
                call set pasted=%%DLTarget[%q%]%%
		call xcopy /s/e/i/d/Y %%DLCart[%q%]%% %VCS%!pasted!
		call echo copying %%DLCart[%q%]%% to %VCS%!pasted!
		set /a "q+=1"
		GOTO :CopyLoop2
	) 
pause
GOTO :Menu

:Single
:Another
set x=0
set w=0
echo Pick a Model:
:SymLoop5
	if defined devices[%x%] (
		call echo %x%: %%devices[%x%]%%
		set /a "x+=1"
		GOTO :SymLoop5
	)
call set /p model_id= Selection:
call set model=%%devices[%model_id%]%%
echo Pick a Branch:
:SymLoop6
	if defined branches[%w%] (
		call echo %w%: %%branches[%w%]%%
		set /a "w+=1"
		GOTO :SymLoop6
	)
call set /p branch_id= Selection:
call set branch=%%branches[%branch_id%]%%
call echo %model% with %branch% versions: %map%
set /A index=%numDevices% * %branch_id%+ %model_id% 
call set d1=%%mappings[%index%]%%xx\
call set root=%%roots[%model_id%]%%%d1%

FOR /f "tokens=*" %%i in ('DIR %root% /a:d /b w*') DO (ECHO %%i\)
set /p version= Type in version of version to checkout:
set next= %root%\%version%
call set DLCart[%y%]= %%next%%
set /a "y+=1"
set /p c= done with download cart(y/N)?: 
if %c%==y (GOTO :CopyLoop3)
GOTO :Another
:CopyLoop3
echo Copying Download Cart to VCS...
	if defined DLCart[%z%] (
		call xcopy /s/e/i/d/Y %%DLCart[%z%]%% %VCS%%model%\%branch%\%version%
		call echo copying %%DLCart[%z%]%% to %VCS%%model%\%branch%\%version%
		set /a "z+=1"
		GOTO :CopyLoop3
	)

 
pause
GOTO :Menu