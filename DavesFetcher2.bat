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
echo Welcome to Dave's Production Version Fetcher!
:Menu
set DLCart[0]=something
set DLTarget[0]=something
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
set k=0
:SymLoop7	
	set x=0
	if defined branches[%k%] (
	:SymLoop9
	if defined devices[%x%] (
		call set sub=%%devices[%x%]%%
		call set branch=%%branches[%k%]%%
		set index = 0
		set /A index=%numDevices% * %k% + %x%
		call set newmap=%%mappings[%index%]%%
		call set p=%%roots[%x%]%%%newmap%xx\
		GOTO :Search
		:Done
		call set /A x+=1
		GOTO :SymLoop9
	)
	call set /A k+=1
	GOTO :SymLoop7
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
set /p family= Enter a software family:
set /p version= Enter a software name:
call set root= %%roots[%model_id%]%%
set next= %root%\%family%\%version%
call set DLCart[%y%]= %%next%%
set /a "y+=1"
set /p c= done with download cart(y/N)?: 
if %c%==y (GOTO :CopyLoop)
GOTO :Another
:CopyLoop1
echo Copying Download Cart to VCS...
	if defined DLCart[%z%] (
		call xcopy /s/e/i/d/Y %%DLCart[%z%]%% %VCS%%model%\%family%\%version%
		call echo copying %%DLCart[%z%]%% to %VCS%%model%\%family%\%version%
		set /a "z+=1"
		GOTO :CopyLoop1
	)


:Cube
echo Pick a Branch for all devices:
:SymLoop2
	if defined branches[%w%] (
		call echo %w%: %%branches[%w%]%%
		set /a "w+=1"
		GOTO :SymLoop2
	)
call set /p branch_id= Selection:
call set branch=%%branches[%branch_id%]%%
:SymLoop3
	if defined devices[%x%] (
		call set model_id=%%devices[%x%]%%
		set /a "x+=1"
		GOTO :SymLoop3
	)
set /p version= Type in version to checkout for all devices(example: C1 of PGC1):
:SymLoop4
if defined roots[%z%] (
        set /A index=%numDevices% * %branch_id% + %z% 
	call set root=%%roots[%z%]%%%%mappings[%index%]%%xx\%%mappings[%index%]%%
        call set DLTarget[%z%]=%%devices[%z%]%%\%%branches[%branch_id%]%%\%%mappings[%index%]%%%version%
	
	

	set next=%root%%version%
	call set DLCart[%z%]=%%next%%
	set /a "z+=1"
        GOTO :SymLoop4
)
:CopyLoop2
echo Copying Download Cart to VCS...
	if defined DLCart[%q%] (
                call set pasted=%%DLTarget[%q%]%%
		call xcopy /s/e/i/d/Y %%DLCart[%q%]%% %VCS%%pasted%
		call echo copying %%DLCart[%q%]%% to %VCS%%pasted%
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
echo %branch_id%
echo %model_id%
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
