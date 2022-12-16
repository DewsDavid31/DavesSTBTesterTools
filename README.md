# DavesSTBTesterTools
A set of tools built to help me be faster at updating STBs and other non testing tasks.

## TestingCompanionV2.py
A python program that creates macros using my own .macro file syntax and can run tradefed commands, shell commands, remote ssh shell commands, button presses and more

### Run a Macro
Screen option of testing companion that will scan your MACRO folder nearby for any .macro files and run them line-by-line, it will stop and warn you of syntax errors

### Create a Macro
The testing companion can walk you through building a macro file of you wish in preset chunks, such as "press a button" or "run a program"

### Download STB locally
The testing companion can also download the most recent files within a drive with a folder structure you can provide by a string in the v2config.json with portions to replace shown by "@@"

## FastRemoteSession.py
A simple python program that runs a putty session from preselected ips you give along with your password and username input, as long as you have a ips.json filled in with a list of ips under "ip" and username under "username" and password under "userpass"

## TradefedResultNamer.py
A python program that will take a given result directory of tradefed, open the xml result file and rename the folder and its .zip file to the naming convention of android certification test results

## old version
This folder contains V1 of the testcompanion, built on windows, with robust support of a single remote drive structure for downloading and autohotkey binding
