@echo off
if not exist .\configs (mkdir .\configs
echo configs does not exist, make that folder and add a config file!
pause
exit
)
:configAgain
echo select your rack/cubes config files:
FOR /F "tokens=*" %%j in ('DIR .\configs /b w*') DO (
		ECHO * %%j
                ECHO *
)
set /p config=Type the name of a .config file from above to use: 
if not exist .\configs\%config% (echo invalid config file try again...
GOTO :configAgain
)

for /f "delims=" %%x in ('findstr /v /c:"//" .\configs\%config%') do (set "%%x")
if not exist %Bots% mkdir %Bots%
set DLCart[0]=something
set DLTarget[0]=something
set y=0
set v=0
set z=0
set q=0
:Another
set x=0
set w=0
echo Welcome to Dave's Keyboard Macro Maker!
:Menu
echo 1: AutoStream Bot(MUX is discontinued)
echo 2: CSG Authorization Bot
echo 3: BVT csv merger and transformer
echo 4: Failure analysis duplicate removal
echo 5: Quit
set /p option= Pick a bot option:
if %option% EQU 5 GOTO :Quit
if %option% EQU 4 GOTO :Analysis
if %option% EQU 3 GOTO :BVT
if %option% EQU 2 GOTO :Auth
if %option% EQU 1 GOTO :Auto
GOTO :Menu
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
GOTO :Menu

:Auth
set /p desc= Enter CSG description for all boxes: 
set /p acti= choose 1. Add, 2.Remove, 3.Update :
if %acti% EQU 1 set sel=send {ENTER} echo send {DOWN}
if %acti% EQU 2 set sel=send {ENTER} echo send {DOWN} echo send {DOWN}
if %acti% EQU 3 set sel=send {ENTER} echo send {DOWN} echo send {DOWN} echo send {DOWN}

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
echo send {ENTER} >> %Bots%CSGBot.ahk
echo send {TAB} >> %Bots%CSGBot.ahk
:Symloop3
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
		echo send {TAB} >> %Bots%CSGBot.ahk
		echo send {TAB} >> %Bots%CSGBot.ahk
		echo send {ENTER} >> %Bots%CSGBot.ahk
		set /a "v+=1"
		GOTO :SymLoop3
	)

echo Esc:: >> %Bots%CSGBot.ahk
echo ExitApp >> %Bots%CSGBot.ahk
START %Bots%CSGBot.ahk

echo Done! Created bot for csg request, just open CSG request form SELECT NONE ON FIRST FIELD and press Tilde!
pause
GOTO :Menu

:BVT
echo place your exported files from Witbe Datalab as an Excel Compatible csv into %csvIn%
pause
echo merging...
copy %csvIn%*.csv  %csvIn%merged.csv
echo ensure the csv is named 'merged.csv' it should be by default!
pause
echo also remove any extra header lines, they should stick out from the block of comma values in notepad!
pause
echo converting...
powershell .\BVTConverter.ps1
echo done! please select only the fields from '369' to end of automated boxes
pause
echo now go to FILE,IMPORT,UPLOAD and upload this file in REPORTS called 'import_as_data.csv'
echo with IMPORT LOCATION with REPLACE DATA AT SELECTED CELL and SEPARATOR TYPE at COMMA
pause
echo Automation tests of BVT sheet are complete! Happy manual testing!
pause
GOTO :Menu


:Analysis
echo place your exported files from Witbe Datalab as a PURE csv into %csvOut%
pause
echo merging...
copy %csvIn%*.csv  %csvIn%merged.csv
echo ensure the csv is named 'merged.csv' it should be by default!
pause
echo converting...
powershell .\BVTAnalysisConverter.ps1
echo done! Please import the file in converter_output into your report and work through failures.
pause
GOTO :Menu
:Quit
pause
exit
