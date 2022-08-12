# DavesSTBTesterTools
A set of personal manual testing tools designed to make trivial updates and housekeeping faster.

# How to install:
## 1. Git clone or Download as Zip file and unpack where ever you want the tools to be
## 2. Double-click Installer.bat
## 3. Select the installer method to be used. (currently DISH and CUSTOM are not supported for a few days)
## 4. Enter the serial numbers and receiver id's of the boxes you have for Keybindings to Autofill your box information
## 5. If you picked CUSTOM: fill out the remaining mapping information of your company's system.
## 6. If anything is wrong later, you can change the variables in the config file using notepad, comments will help you.
## 7. You are good to go!

# How to use:
Whenever a new release of STB software is up, run DavesReleaseUpdater, enter the cube/rack you wish to update by typing its associated config file, or the general installed config file for your method (ex: DISH.config) and it will automatically show you the most recent versions of each STB and download it to your Desktop VCS file. If you want to change where your STB files go, just change 'VCS=.\VCS' to be wherever you want the files to go. They will be installed sorted by Device type and Software Branch name in nested folders.

Whenever you need a specific release for a single STB box or a whole cube/rack and don't want the slowness of installing from a remote drive, use the DavesReleaseFetcher to look up and download your whole suite of devices(whole cube/rack), a single release for a single box(single) or a release that you know the folder names of but not the name of (exotic). Just select that option and input the needed information and your config file will find the STB software you need. When you are ready to download it to your desktop just enter y or Y in response to 'done with download cart(y/N)?' and all of your so far found software will be downloaded at once to prevent lag or hogging the remote connection from others.

Whenever you need to fill out a form or massage csv data for a form, use the DavesKeyBinder. This tool has a selection of hotkey bindings in the form of AutoHotKey Scripts that can automatically pass tests, automatically click quickly, scrub csv's for specific forms and more, for more info on their usage see the below information on the readme on what each one does.

# The Tools:
## DavesReleaseFetcher
A batch script that fetches versions of STB software based on a root remote drive quickly, includes whole cubes, single files and searching the directory


## DavesReleaseUpdater
A batch script meant to keep your local versions of STB software up to date by grabbing the most recent of each branch on remote drive

## DavesKeyBinder
An autohotkey keyboard macro maker that is compatible with certain pieces of STB software and request forms, your milage may vary
!In order to use BVT function and CSG macros, use DISH installer once available to get the proper config files!


# The built-in KeyBindings:
All of these keys have Escape key as a panic button that kills them except AutoClicker!
To use these, just double-click them and they are ready to use. Be sure to read what keys do what before using them below:

## mouseCoords
a utility for showing mouse location in pixels for future autohotkey scripts, only ran using Powershell.

## AutoClicker
an autohotkey script bound to grave key/back tick that clicks few times a second for quick button presses on remote STB instances. Press the same key to start/stop it.

## AutoCopier
an autohotkey script bound to Home key that copies an 'expected' string in our testing software and pastes it into the 'actual' field for passed tests.

## AutoPasser
an autohotkey script bound to Insert key that copies an 'expected' string in our testing software and pastes it into the 'actual' field for passed tests as well as automatically passing the step if your testing software has pass tied to Ctrl-P and tabs back to focus for rapid fire. BE CAREFUL NOT TO PASS WITHOUT LOOKING THAT'S BAD PRACTICE.

## muxAutofill
an autohotkey script bound to END key that automatically fills in common data for an in-house application, to use you must click the 'stream file name' box first then press END, it will fill all values that don't change and presses 'run'. If you need more info, consult the more IP laden config file or myself directly.

## Folders:
### ActiveBots
default location of current AutoHotkey macros constructed
### Configs
default location for config files for specific cubes, can be loaded by all daves tools and is required to function.
If you ever change cubes, use different devices use another config to be able to seamlessly use tools on all the above.
I will be supporting configs for my company accessible if shared with you by the installer.bat.
### VCS
default location of local versions of STB software sorted by device and then release name, by default uses patten <version char><version char>xx/<version char><version char><release char><number>

