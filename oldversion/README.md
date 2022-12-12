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
![fetch_menu](https://user-images.githubusercontent.com/33354172/189176070-6dce5804-1239-431e-922d-92a2ff742ff5.png)

This menu is for grabbing product files from a remote drive onto your harddrive for quicker access or seeing current versions on the drive.
#### 1.Fetch Release for a Whole Cube/Rack
![fetch_whole_cube](https://user-images.githubusercontent.com/33354172/189177094-b6e672e4-68a9-4f33-8c82-eb2156f8844e.png)

This selection prompts a version you wish to fetch for every device that you have in your config file.
![fetch_whole_cube_prompt](https://user-images.githubusercontent.com/33354172/189182225-88630762-1175-4ace-ab02-064fc4c8d88e.png)
![fetch_whole_cube_results](https://user-images.githubusercontent.com/33354172/189182390-3cbc66cf-f34f-4285-a515-3eabc6c4ca94.png)

Simply enter the family in your config selection and then a specific version. Here we selected branch_1 version a1

#### 2.Fetch a Single Release
![fetch_single_prompt](https://user-images.githubusercontent.com/33354172/189177070-97cf7902-8e48-4932-b297-d07ec4fc33e4.png)

This selection will prompt what version of software you want for a single STB in your config file.
![fetch_single_prompt_2](https://user-images.githubusercontent.com/33354172/189184488-7ffb0eef-5a01-4046-8f74-aadecfa35776.png)

Then it shows all versions in that family and asks you to manually type one.

![fetch_single_results](https://user-images.githubusercontent.com/33354172/189184499-a734b70a-c24f-477e-81df-fc8ac132a242.png)

It then copies that version to your DOWNLOAD CART, an array of copies to be done that you can say to do or keep adding versions and do it later.

#### What is the DOWNLOAD CART?
An array of current downloads/copies you have selected so far to be done all at once to not clog the Virtual/Physical Drive of the repo for everyone, also saves time.

#### 3.Fetch an Exotic Release(...)
![fetch_exotic_prompt](https://user-images.githubusercontent.com/33354172/189177197-fffd0bc1-3591-435c-a520-190749b8062c.png)

This selection will fetch a specific non-human readable software codename or whatever the folder is named without questions asked.

![fetch_exotic_prompt_and_results](https://user-images.githubusercontent.com/33354172/189182495-85135c67-eea9-4a57-b739-39c3bb715ccb.png)

Here we chose software in abxx/abb1.

#### 4.Show me every current release version
![show_me_function](https://user-images.githubusercontent.com/33354172/189177132-69a004bf-47cd-4db0-93f7-583e7c8c5067.png)

This Selection searches the repository for the newest files in each software mapping in your config file and displays them, this is helpful for seeing what the new production software might be.

#### 5.Fetch Updates
![fetch_updates](https://user-images.githubusercontent.com/33354172/189182877-3224af53-e396-4e22-a5a2-916812a025a1.png)


Automatically checks each directory in config mappings for each software release and tries to copy the newest file, and if it already exists just says "0 files copied" and doesn't copy anything.

#### 6.put a watch program up to notify me...
![watch](https://user-images.githubusercontent.com/33354172/189183344-39cb8f99-e350-498b-a15a-9bb6a29de90a.png)


Creates another batch file from itself that checks the conifgured repository for a build file in a mapping you provided to see if the software is ready to fetch. Your mileage may vary if you don't have these build files at your workplace. Supports making multiple, will be saved in MACRO file.

#### 7.Exit
Returns to Main Menu.

### 2.Set Keyboard Macros
![macro_menu](https://user-images.githubusercontent.com/33354172/189173969-2e817bbf-afeb-49c3-a670-9ae073861076.png)

This menu is for setting, editing and generating AutoHotKey scripts for your keyboard.
### 1.AutoStream Bot
Specific Autohotkey for an in-house utility, only compatible with dish configs, no more information on it without IP.

### 2.CSG Authorization bot
Specific Autohotkey for an in-house utility, only compatible with dish configs, no more information on it without IP.

### 3. Show/Edit my keyboard mappings
![macro_edit_show](https://user-images.githubusercontent.com/33354172/189174960-9e2a6d8e-d540-418e-848a-d79e1ef48e9d.png)

This menu shows and edits all your current AutoHotKey macro files in MACRO, you can change the folder searched in your config file.
#### 1. Delete this mapping

Unpairs a key binding by changing selected AHK file's key to unused HELP key.

#### 2. Map to a new key
![macro_mapping](https://user-images.githubusercontent.com/33354172/189184283-ad1ce702-9e38-4e87-b0ce-992dbb0a8710.png)


Shows a selection of possible text representations of AHK keys that are not in the way of testing. Simply type one and the companion will directly replace the key in the AHK file with that one, then runs it for you.

#### 1. Start this key binding
Directly runs the AHK file for that keybind. The companion can't know if it is running or not.

#### 1. Exit
Returns to Macro Menu.



### 4. Quit
Exits to Main Menu.

### 3.CSV scrubbing and BVT reports
![csv_menu](https://user-images.githubusercontent.com/33354172/189183598-0845e6dd-7dd8-42ca-a838-41dcccea382b.png)

The menu for scrubbing CSV files for reports, this feature is largely DISH specific and thus I can't say much or show much without specific config files or powershell helper scripts. The tool will guide you if it is used with the proper configs and files.

### 4.Change Config File
The menu you use to change the products you want to work with or possibly change to a different rack of products, I suggest making a config file off of your company template or Template.config for each rack you have. Essentially takes you to the Config Menu from earlier.

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
an autohotkey script bound to END key that automatically fills in common data for an in-house application for starting a test on setup B, to use you must not click anything first then press END when Start Test window is up, it will fill B in the proper slot and automatically start the test.


## Folders:
### MACRO
default location of current AutoHotkey macros constructed
### CONFIG
default location for config files for specific cubes, can be loaded by all daves tools and is required to function.
If you ever change cubes, use different devices use another config to be able to seamlessly use tools on all the above.
I will be supporting configs for my company accessible if shared with you on google drive.
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
