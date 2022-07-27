# DavesSTBTesterTools
A set of personal manual testing tools designed to make trivial updates and housekeeping faster.

## DavesFetcher2
A batch script that fetches versions of STB software based on a root remote drive quickly, includes whole cubes, single files and searching the directory


## DavesUpdater2
A batch script meant to keep your local versions of STB software up to date by grabbing the most recent of each branch on remote drive

## DavesBot
An autohotkey maker that is compatible with certain pieces of STB software and request forms, your milage may vary
!In order to use BVT function, proprietary Powershell file must be used for now, doesn't come with this package due to possible IP!

## mouseCoords
a utility for showing mouse location in pixels for future autohotkey scripts

## AutoClicker
an autohotkey script bound to grave key/back tick that clicks few times a second for quick button presses on remote STB instances.

## AutoCopier
an autohotkey script bound to Home key that copies an 'expected' string in our testing software and pastes it into the 'actual' field for passed tests.

## AutoPasser
an autohotkey script bound to Insert key that copies an 'expected' string in our testing software and pastes it into the 'actual' field for passed tests as well as automatically passing the step if your testing software has pass tied to Ctrl-P and tabs back to focus for rapid fire. BE CAREFUL NOT TO PASS WITHOUT LOOKING THAT'S BAD PRACTICE.

## Folders:
### ActiveBots
default location of current AutoHotkey macros constructed
### Configs
default location for config files for specific cubes, can be loaded by all daves tools and is required to function
### VCS
default location of local versions of STB software sorted by device and then release name, by default uses patten <version char><version char>xx/<version char><version char><release char><number>

  Question: Why can't my configs work?
     Answer: the config is built for my workplace's file structure and some IP is involved, so the real config and BVTconverter.ps1 are missing intentionally, if you want this in my company contact me directly. If not replace the Enter X portions with the things your workplace needs, it should function as long as your file structures follow the formats given. Use template.config for this.
