@echo off
if not exist .\CONFIG (mkdir .\CONFIG
echo .\CONFIG does not exist, make that folder and add a config file!
pause
exit
)
:configAgain
echo your config files:
FOR /F "tokens=*" %%j in ('DIR .\CONFIG /b w*') DO (
		ECHO * %%j
                ECHO *
)
set /p config= Type the name of your rack/cubes .config file from above to use: 
if not exist .\CONFIG\%config% (echo invalid config file try again...
GOTO :configAgain
)

for /f "delims=" %%x in ('findstr /v /c:"//" .\CONFIG\%config%') do (set "%%x")
set /a "maxDev=numDevices-1"
if not exist %VCS% mkdir %VCS%
:Menu
echo Welcome to Daves Manual Testing Companion!
set y=0
set k=0
set z=0
set q=0
set x=0
set w=0
set v=0
set watchIndex=0
echo 1: Fetch a Release/Releases
echo 2: Set Keyboard Macros/BVT csv scrubbing
echo 3: Change Config File
echo 4: Exit
set /p option= Pick an option:
if %option% EQU 4 GOTO :Quit
if %option% EQU 3 GOTO :configAgain
if %option% EQU 2 GOTO :MacroMenu
if %option% EQU 1 GOTO :FetchMenu
GOTO :Menu
:FetchMenu
set y=0
set k=0
set z=0
set q=0
set x=0
set w=0
set v=0
echo 1: Fetch Release for a Whole Cube/Rack
echo 2: Fetch a Single Release
echo 3: Fetch an Exotic Release(no known intent, but known software name) 
echo 4: Show me every current release version
echo 5: Fetch Updates
echo 6: put a watch program up to notify me when a new version is complete
echo 7: Exit
set /p option= Pick an option:

if %option% EQU 7 GOTO :Menu
if %option% EQU 6 GOTO :Watch
if %option% EQU 5 GOTO :Update
if %option% EQU 4 GOTO :Show
if %option% EQU 3 GOTO :Exotic
if %option% EQU 2 GOTO :Single
if %option% EQU 1 GOTO :Cube
GOTO :FetchMenu

:Watch
set w=0
set z=0
set index=0
echo Pick a Branch for to watch for updates:
:SymLoop25
	if defined branches[%w%] (
		call echo %w%: %%branches[%w%]%%
		set /a "w+=1"
		GOTO :SymLoop25
	)
setlocal ENABLEDELAYEDEXPANSION
set /p watchedBranch= Selected branch:
set /p vers= type a version(example A1):
call set branchName= %%branches[!watchedBranch!]%%
echo ^@echo off > %Bots%\watch!watchIndex!.bat
echo ^:oneleft >> %Bots%\watch!watchIndex!.bat
echo ^echo waiting to recheck %branchName% %vers%... >> %Bots%watch!watchIndex!.bat
echo ^set failed=ff>> %Bots%\watch!watchIndex!.bat
echo timeout /t 60 >> %Bots%\watch!watchIndex!.bat
 :SymLoop41
if defined roots[%z%] (
	call set root=%%roots[%z%]%%%%mappings[%index%]%%%ending%\%%mappings[%index%]%%
	call set next=!root!%vers%
        echo ^set snapexist=t>> %Bots%\watch!watchIndex!.bat
        echo ^set nonsnap=t>> %Bots%\watch!watchIndex!.bat
        echo if not exist !next!\USB\md5bin.txt ^set nonsnap=f>> %Bots%\watch!watchIndex!.bat
        echo if not exist !next!\md5.txt ^set snapexist=f>> %Bots%\watch!watchIndex!.bat
        echo ^set oredexist=%%nonsnap%%%%snapexist%%>> %Bots%\watch!watchIndex!.bat
        echo if %%oredexist%%==%%failed%% goto oneleft>> %Bots%\watch!watchIndex!.bat
	set /a "z+=1"
	set /a "index+=1"    
        GOTO :SymLoop41
)
echo ^echo %branchName% version %vers% is ready in the repo!! >> %Bots%\watch!watchIndex!.bat
echo ^pause >> %Bots%\watch!watchIndex!.bat
echo ^exit >> %Bots%\watch!watchIndex!.bat
start %Bots%\watch!watchIndex!.bat
set /a "watchIndex+=1"
echo watch program set for %watchedBranch% version %vers%, this opened terminal will notify you when the version is available
goto :FetchMenu

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

	call set p=%%roots[%d%]%%%%mappings[%k%]%%%ending%\
	call set branch=%%branches[%r%]%%
	call set sub=%%devices[%d%]%%
	set /a "k+=1"
	set /a "d+=1"
	if %d%==%maxDev% (set d=0
	set /a "r+=1"
 )
	GOTO :Search
	:Done1
	GOTO SymLoop7
)
pause
GOTO :FetchMenu

:Search
set b=
FOR /F "delims=" %%a IN ('dir "%p%" /b /ad-h /t:w /od') DO SET b=%%a
echo most recent %branch% software for %sub% is: %b%
GOTO :Done1
pause
exit


:Exotic
echo Pick a Model:
:SymLoop11
	if defined devices[%x%] (
		call echo %x%: %%devices[%x%]%%
		set /a "x+=1"
		GOTO :SymLoop11
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
GOTO :FetchMenu

:Cube
set w=0
set x=0
set z=0
set q=0
set root='none'
echo Pick a Branch for all devices:
:SymLoop12
	if defined branches[%w%] (
		call echo %w%: %%branches[%w%]%%
		set /a "w+=1"
		GOTO :SymLoop12
	)
call set /p branch_id= Selection:
call set branch=%%branches[%branch_id%]%%
set /p version= Type in version to checkout for all devices(example: C1 of PGC1):
set /a "index=numDevices*branch_id"
setlocal ENABLEDELAYEDEXPANSION
:SymLoop4
if defined roots[%z%] (
	call set root=%%roots[%z%]%%%%mappings[%index%]%%%ending%\%%mappings[%index%]%%
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
GOTO :FetchMenu

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
call set d1=%%mappings[%index%]%%%ending%\
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
GOTO :FetchMenu
:Update
set d=0
set x=0
set r=0
set k=0
set b=0
set /a "maxDev=numDevices-1"
if not exist %VCS% mkdir %VCS%
echo Welcome to Dave's Current Release Version Updater!
setlocal ENABLEDELAYEDEXPANSION
:SymLoop21	
if defined mappings[%k%] (
	call echo Updating %%devices[%d%]%% to VCS Current folder ...
	call set p=%%roots[%d%]%%%%mappings[%k%]%%%ending%\
	call set branch=%%branches[%r%]%%
	call set sub=%%devices[%d%]%%
	set /a "k+=1"
	set /a "d+=1"
	if %d%==%maxDev% (set d=0
	set /a "r+=1"
 )
	GOTO :Search2
	:Done
	GOTO SymLoop21
)
pause
GOTO :FetchMenu
:Search2
set b=
FOR /F "delims=" %%a IN ('dir "%p%" /b /ad-h /t:w /od') DO SET b=%%a
echo most recent %branch% software for %sub% is: %b%
if not exist "%VCS%%sub%\%branch%\%b%" mkdir %VCS%%sub%\%branch%\%b%
set source=!p!\!b!
set target=%VCS%%sub%\%branch%\%b%
xcopy /s/e/i/d/Y %source% %target%
GOTO :Done
GOTO :FetchMenu
:MacroMenu
echo 1: AutoStream Bot(MUX is discontinued)
echo 2: CSG Authorization Bot
echo 3: BVT csv transformer
echo 4: BVT csv merger and duplicate removal
echo 5: Show/edit my keyboard macro bindings
echo 6: Quit
set /p option= Pick a bot option:
if %option% EQU 6 GOTO :Menu
if %option% EQU 5 GOTO :Bindings
if %option% EQU 4 GOTO :Strip
if %option% EQU 3 GOTO :BVT
if %option% EQU 2 GOTO :Auth
if %option% EQU 1 GOTO :Auto
GOTO :MacroMenu
:Auto
echo Please open up AutoStream.exe
pause
echo Pick a Branch for mux:
:SymLoop2
	if defined branches[%w%] (
		call echo %w%: %%branches[%w%]%% 
		set /a "w+=1"
		GOTO :SymLoop2
	)
call set /p branch_id= Selection:
call set branch=%%branches[%branch_id%]%%
set /A index1= %numDevices% * %branch_id% + 4
set /A index2= %numDevices% * %branch_id% + 0
set /A index3= %numDevices% * %branch_id% + 3
set /A index4= %numDevices% * %branch_id% + 7
set /A index5= %numDevices% * %branch_id% + 6
set /A index6= %numDevices% * %branch_id% + 1
set /A index7= %numDevices% * %branch_id% + 10
set /A index8= %numDevices% * %branch_id% + 5
set /A index9= %numDevices% * %branch_id% + 9
set /A index10= %numDevices% * %branch_id% + 8
set /A index11= %numDevices% * %branch_id% + 2
set /p version= Type in version to checkout for all devices(example: C1 of PGC1):
call set model1=%%mappings[%index1%]%%%version%
call set model2=%%mappings[%index2%]%%%version%
call set model3=%%mappings[%index3%]%%%version%
call set model4=%%mappings[%index4%]%%%version%
call set model5=%%mappings[%index5%]%%%version%
call set model6=%%mappings[%index6%]%%%version%
call set model7=%%mappings[%index7%]%%%version%
call set model8=%%mappings[%index8%]%%%version%
call set model9=%%mappings[%index9%]%%%version%
call set model10=%%mappings[%index10%]%%%version%
call set snap=%%mappings[%index11%]%%%version%
echo ~:: > %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %branch% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %version% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model1% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %snap% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model2% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %snap% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model3% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model4% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model5% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model6% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model7% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model8% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model9% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %model10% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send %snap% >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {TAB} >> %Bots%AutoStreamBot.ahk
echo send {ENTER} >> %Bots%AutoStreamBot.ahk
echo send {SPACE} >> %Bots%AutoStreamBot.ahk
echo Esc:: >> %Bots%AutoStreamBot.ahk
echo ExitApp >> %Bots%AutoStreamBot.ahk
	 
START %Bots%AutoStreamBot.ahk

echo Mux Bot is ready to run! Press ~ to start bot
pause
GOTO :MacroMenu

:Auth
set v=0
set /p desc= Enter CSG description for all boxes: 
set /p acti= choose 1. Add, 2.Remove, 3.Update 4.Collection Hit :
set /p cheatsheet= choose 1.RECOMMENDED Use only device 0 for inventory's sanity 2.Let macro enter every single device :
if %acti% EQU 1 set sel=send {ENTER} send {DOWN}
if %acti% EQU 2 set sel=send {ENTER} send {DOWN} send {DOWN}
if %acti% EQU 3 set sel=send {ENTER} send {DOWN} send {DOWN} send {DOWN}
if %acti% EQU 4 set sel=send {ENTER} send {DOWN} send {DOWN} send {DOWN}
echo ~:: > %Bots%CSGBot.ahk
echo send MouseMove 400,400 >> %Bots%CSGBot.ahk
echo send Click >> %Bots%CSGBot.ahk
echo send {TAB} >> %Bots%CSGBot.ahk
echo send {ENTER} >> %Bots%CSGBot.ahk
echo send {DOWN} >> %Bots%CSGBot.ahk
echo send {ENTER} >> %Bots%CSGBot.ahk
echo send {TAB} >> %Bots%CSGBot.ahk
echo send {TAB} >> %Bots%CSGBot.ahk
echo send {ENTER} >> %Bots%CSGBot.ahk
echo send {DOWN} >> %Bots%CSGBot.ahk
if %acti% EQU 4 echo send {DOWN} >> %Bots%CSGBot.ahk
echo send {ENTER} >> %Bots%CSGBot.ahk
echo send {TAB} >> %Bots%CSGBot.ahk
if %acti% EQU 4 echo send {ENTER}>> %Bots%CSGBot.ahk
if %acti% EQU 4 echo send {DOWN}>> %Bots%CSGBot.ahk
if %acti% EQU 4 echo send {DOWN}>> %Bots%CSGBot.ahk
if %acti% EQU 4 echo send {DOWN}>> %Bots%CSGBot.ahk
if %acti% EQU 4 echo send {ENTER} >> %Bots%CSGBot.ahk
if %acti% EQU 4 echo send {TAB} >> %Bots%CSGBot.ahk
:Symloop31
if defined devicesReceiverNum[%v%] (
		echo send {ENTER} >> %Bots%CSGBot.ahk
		echo sleep 6000 >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		echo send {SPACE} >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		echo %sel% >> %Bots%CSGBot.ahk
		echo send {ENTER} >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		call echo send %%devicesReceiverNum[%v%]%% >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		call echo send %%devicesSerials[%v%]%% >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		call echo send %%devicesTitles[%v%]%% >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		echo send %desc% >> %Bots%CSGBot.ahk
		if %cheatsheet% EQU 1 echo send .Do this to whole cube this receiver is part of. >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		echo send {ENTER} >> %Bots%CSGBot.ahk
		set /a "v+=1"
                if %cheatsheet% EQU 1 GOTO :skiploop31
		GOTO :SymLoop31
	)
:skiploop31
echo Esc:: >> %Bots%CSGBot.ahk
echo ExitApp >> %Bots%CSGBot.ahk
START %Bots%CSGBot.ahk

echo Done! Created bot for csg request, just open CSG request form SELECT NONE ON FIRST FIELD and press Tilde!
pause
GOTO :MacroMenu

:BVT
echo WARNING ensure the csv is pure csv and merged already, if in doubt, use merger and duplicate remover first.
pause
set /p csvFile=type name of BVT file in %csvIn%: 
pause
echo converting...
powershell .\BVTConverter.ps1
echo also remove any extra header lines, they should stick out from the block of comma values in notepad!
echo done! please select only the fields from '369' to end of automated boxes
pause
echo now go to FILE,IMPORT,UPLOAD and upload this file in %csvIn% called 'import_as_data.csv'
echo with IMPORT LOCATION with REPLACE DATA AT SELECTED CELL and SEPARATOR TYPE at COMMA
pause
echo Automation tests of BVT sheet are complete! Happy manual testing!
pause
GOTO :MacroMenu


:Strip
set /p csvFile=type name of BVT file in %csvIn%: 
pause
echo merging...
copy %csvIn%*.csv  %csvIn%merged.csv
echo delete witbes silly "sep=," and any extra label headers shown as "Time;..."
pause
echo making sure file is pure csv...
powershell -Command "(Get-Content '%csvIn%merged.csv' -Raw) -Replace [regex]::Escape(';'),[regex]::Escape(',') | Set-Content '%csvIn%merged.csv'"pause
echo stripping of duplicates...
powershell -Command "Import-Csv '[regex]::Escape(%csvIn%%csvFile%)' -Delimiter "," -Header "time","unused", "deviceName","unused2", "scenarioName", "unused3","status" | sort deviceName,scenarioName -Unique | Set-Content -Path '[regex]::Escape(%csvIn%%csvFile%)'"
echo done!
pause
GOTO :MacroMenu



:Bindings
SETLOCAL EnableDelayedExpansion
set bindIndex=0
set repKey = "Help::"
echo NOTE help is the key used to make macros unbound to any key
FOR /F "tokens=*" %%j in ('DIR %Bots%\*.ahk /b w*') DO (
		set /p binding=< %Bots%\%%j
                ECHO *!bindIndex!: %%j bound to key: !binding!
                ECHO *
                set boundFiles[!bindIndex!]=%%j
                set currentBind[!bindIndex!]=!binding!
                set /a "bindIndex+=1"
)
ECHO !bindIndex!: Quit
set /p bindPrompt=Select a binding to modify or !bindIndex! to quit: 
IF /i %bindPrompt% EQU !bindIndex! GOTO :Menu
echo 1. Delete this Mapping
echo 2. Map to a new key
echo 3. Start this key binding
echo 4. Exit
set /p mapPrompt=Select and option: 
IF %mapPrompt% EQU 1 GOTO :DelMap
IF %mapPrompt% EQU 2 GOTO :ReMap
IF %mapPrompt% EQU 3 GOTO :startBind
IF %mapPrompt% EQU 4 GOTO :Bindings
GOTO :Bindings
:DelMap
set repKey="Help"
GOTO :Overwrite
:ReMap
echo Valid keys:
echo CapsLock
echo ScrollLock 
echo Insert
echo Home
echo End
echo PgUp
echo pgDn
echo F1 or type any F with a number
echo LWin
echo LControl
echo LAlt
echo RAlt
echo Media_Play_Pause
echo Media_Stop
echo PrintScreen
set /p newKey=Enter key to bind from above CASE SENSITIVE!: 
set repKey=%newKey%
GOTO :Overwrite
:Overwrite
set writeIndex=0
call set targetFile=%Bots%\%%boundFiles[!bindPrompt!]%%
call set targetBind=%%currentBind[!bindPrompt!]%%
powershell -Command "(Get-Content %targetFile% -Raw) -Replace [regex]::Escape('%targetBind%'),[regex]::Escape('%repKey%::') | Set-Content %targetFile%"
if !mapPrompt! EQU 1 echo %targetFile% unbound! 
if !mapPrompt! EQU 2 echo %targetFile% bound to %repKey%!
start %targetFile%
echo %repKey% Hotkey active!
GOTO :Bindings
:startBind
call set targetFile=%Bots%\%%boundFiles[!bindPrompt!]%%
call set targetBind=%%currentBind[!bindPrompt!]%%
start %targetFile%
echo macro on %targetBind% key active!
GOTO :Bindings
:Quit
exit

