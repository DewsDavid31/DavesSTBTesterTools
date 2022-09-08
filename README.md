# DavesSTBTesterTools
A set of personal manual testing tools designed to make trivial updates and housekeeping faster.

# How to install:
## 1. Git clone or Download as Zip file and unpack where ever you want the tools to be
## 2. Get the config file(DISH.config) required from my link here: https://drive.google.com/drive/folders/18_xPVujysROK0kUrtEp94k_iKbLofKvh its unlocked only to DISH employees, or copy and modify the template config included in the ZIP if you don't have the access.
## 3. Add serial box serials/numbers as instructed on comments in config file if you want to use hotkeys
## 4. You are good to go!

# How to use:
## Config Menu:
![config](https://user-images.githubusercontent.com/33354172/189170191-07f875c2-627c-48bc-b3a6-7882f9b0757b.png)
This menu is what you see upon starting the testing companion bat file, it will display all .config files in your CONFIG folder included. These files contain all the mappings to your STB software in your repo and are required to make the companion function. Every time you start the application you must type the full name of a config file in CONFIG in order to let your testing companion be usable in multiple products and have business IP in a different spot.
![config_entry](https://user-images.githubusercontent.com/33354172/189171235-be806174-c88d-443e-b40d-67ba98a53fad.png)
These files are editable to add new software versions. For demo purposes you get a Demo.config and a test_repo file structure to try out the tool without a workplace repository drive.

## Main Menu
![main_menu](https://user-images.githubusercontent.com/33354172/189171422-8b3d592f-e0ad-4bc1-b644-ac7f0a2297cc.png)
This Menu has five sub-menus as of this version:
### 1.Fetch a Release/Releases
This menu is for grabbing product files from a remote drive onto your harddrive for quicker access or seeing current versions on the drive.

### 2.Set Keyboard Macros
This menu is for setting, editing and generating AutoHotKey scripts for your keyboard.

### 3.CSV scrubbing and BVT reports
The menu for scrubbing CSV files for reports, this feature is largely DISH specific and thus I can't say much or show much without specific config files or powershell helper scripts. The tool will guide you if it is used with the proper configs and files.
### 4.Change Config File
The menu you use to change the products you want to work with or possibly change to a different rack of products, I suggest making a config file off of your company template or Template.config for each rack you have.
### 5.Exit
As the name implies, you just quit the program, the testing companion is made to be kept open all day and swap config files for testing workdays but sometimes you need to exit the tool.

# The Tools:
## TestingCompanion
An all-in-one batch script that fetches versions of STB software based on a root remote drive quickly, includes whole cubes, single files and searching the directory as well as a autohotkey keyboard macro maker that is compatible with certain pieces of STB software and request forms.

# The built-in KeyBindings:
All of these keys already included have Escape key as a panic button that kills them except AutoClicker!
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

## AutoTestSetter
an autohotkey script bound to END key that automatically fills in common data for an in-house application for starting a test on setup B, to use you must click the not click anything first then press END when Start Test window is up, it will fill B in the proper slot and automatically start the test.


## Folders:
### MACRO
default location of current AutoHotkey macros constructed
### CONFIG
default location for config files for specific cubes, can be loaded by all daves tools and is required to function.
If you ever change cubes, use different devices use another config to be able to seamlessly use tools on all the above.
I will be supporting configs for my company accessible if shared with you by the installer.bat.
### VCS
default location of local versions of STB software sorted by device and then release name, by default uses patten <version char><version char>xx/<version char><version char><release char><number>
### test_repo
a demo repository to use demo.config if you just want to see the tool work.

## Limitations:
1. If a family of software goes by the same name, but its version are bounded such as software in 2015 being ABA1 to ABA3 but a new version in present day ABA4 is called by another product name, the fetcher can't know the difference and will fetch ABA4 for both the 2015 name and the present name and store them in both folders.
2. Regex isn't compatible with endings environment variable, and only a (family)(Ending)\(family)(version)\ of the same string size is the possible architecture of the repo.
3. The repo must be a drive that is accessible.
4. config files can't know the number of items in them and will naively overwrite previous variables if written again. Use provided numberOf... variables to fix this.
5. Whitespace in config files beyond a NEWLINE character will be read and ignored, but will echo all environment variables
