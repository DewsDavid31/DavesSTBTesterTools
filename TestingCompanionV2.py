# uncomment these imports if Pip is up to date
import subprocess
import os
import pyautogui
import json
import paramiko as pm
PRESS = "press"
KEYBOARD = "keyboard"
CLICK = "click"
HOTKEY = "hotkey"
SUBPROCESS = "subprocess"
SHELL = "shell"
REMOTE = "remote"
REMOTE_SUBPROCESS = "remotesubprocess"
SCRAPE_FILES = "scrape"
PRINT_RESULTS = "print"
CLEAR = "clear"
IF_TRIGGER = "if"
IF_NOT_TRIGGER = "ifnot"
EXPORT_ENV = "export"
PROMPT = "prompt"
# syntax for macros:
# each of these formats is accepted as a line in a .macro file loaded by this application, nothing more
# each is read and computed line-by-line
#
# press <keyname>
# presses that key at current location
#
# keyboard <text>
# sends keyboard strokes at current location of text given
#
# click <xpixels> <ypixels>
# clicks at current location is no args are given or location in pixels x,y
#
# hotkey <keyname> <keyname>...
# holds each key by its given name at the same time
#
# subprocess <application> <terminal command>...
# does terminal command for application and pipes arguments into its i/o stream used on tradefed
#
# shell <terminal command> <terminal command>...
# directly runs posix commands given after shell
#
# remote <ip> <username> <password> <terminal command>....
# ssh into ip with username and password, then runs terminal commands given
#
# remotesubprocess <ip> <username> <password> <application> <terminal command>.... <endstring>
# ssh into ip with username and password, then runs terminal command until endstring is found, then sends terminal commands into its i/o stream, used on tradefed
#
# scrape <filepath> <pass start of result> <pass end of a result> <fail start of result> <fail end of a result> <norun start of result> <norun end of a result>
# scrapes all passing, failing and norun results endcapped on either end by given text, used by email to give results later
#
# print
# prints current scraped results
#
# clear
# clears current results scraped
#
# if <string> <macro path> <resultpath> <resultfile>
# runs another macro by its path when string is found in the most recent folder in the path inside the file provided
#
# ifnot <string> <macro path> <resultpath> <resultfile>
# runs another macro by its path when string is NOT found in the most recent folder in the path inside the file provided
#
# export <export name> <export value>
# sets export in shell using os.putenv
#
# prompt <message>
# prompts user to do something before continuing
class PatternHandler:
    def pattern(self, pattern_string, variables, args):
        temp_string = pattern_string[:]
        for key, val in zip(variables,args):
            temp_string = temp_string.replace(key, val)
        return temp_string

    def find_most_recent_with(self, result_path, file, string):
        curr_dir = os.getcwd()
        os.chdir(result_path)
        directory =[d for d in os.listdir(result_path) if os.path.isdir(d)]
        most_recent = max(directory, key=os.path.getmtime)
        file_raw = open(os.path.join(most_recent, file), 'r')
        file_lines = "".join(file_raw.readlines())
        if string in file_lines:
            file_raw.close()
            return True
        file_raw.close()
        os.chdir(curr_dir)
        return False

    def find_vars(self, string):
        found = []
        found_text = "@"
        in_var = False
        for charac in string:
            if in_var:
                found_text += charac
            if charac == "@":
                if in_var:
                    if found_text not in found:
                        found.append(found_text)
                    found_text = "@"
                in_var = not in_var
        return found

    def find_enclosed_pattern(self, string, start_pattern, end_pattern):
            found = []
            found_text = ""
            in_var = False
            index = 0
            for charac in string:
                if in_var and index >= len(end_pattern):
                    found.append(found_text.replace(' ',''))
                    found_text = ""
                    index = 0
                    in_var = False
                elif in_var and charac == end_pattern[index]:
                    index += 1
                elif in_var and charac != end_pattern[index]:
                    found_text += charac
                    index = 0
                elif index == len(start_pattern):
                    in_var = True
                    index = 0
                elif charac == start_pattern[index]:
                    index+=1
                else:
                    index = 0
            return found


class ResultsHandler:
    def __init__(self):
        self.passes = []
        self.failures = []
        self.inconclusive = []
        self.pattern_handler = PatternHandler()

    def clear(self):
        self.passes =[]
        self.failures = []
        self.inconclusive = []

    def scrape_pattern(self, file, pass_start, pass_end, fail_start, fail_end, norun_start, norun_end):
        scraped_file = open(file, 'r')
        raw_text = "".join(scraped_file.readlines()).strip()
        self.passes.extend(self.pattern_handler.find_enclosed_pattern(raw_text, pass_start, pass_end))
        self.failures.extend(self.pattern_handler.find_enclosed_pattern(raw_text, fail_start, fail_end))
        self.inconclusive.extend(self.pattern_handler.find_enclosed_pattern(raw_text, norun_start, norun_end))
        scraped_file.close()
        
    def scrape_files(self, files, pass_start, pass_end, fail_start, fail_end, norun_start, norun_end):
        for file in files:
            if ".xml" in file:
                self.scrape_pattern(file, pass_start, pass_end, fail_start, fail_end, norun_start, norun_end)

    def show_results(self):
        result_str = "Failures: \n"
        result_str += "\n".join(self.failures)
        result_str += "\nPasses: " + str(len(self.passes)) + " Noruns: " + str(len(self.inconclusive))
        return result_str

    def failure_trigger_macro(self, result_trigger, macro):
        if result_trigger in self.failures:
            self.macro_flag = macro

class MacroHandler:
    def __init__(self):
        self.pattern_handler = PatternHandler()
        self.results_handler = ResultsHandler()

    def read_macro(self, macro_path):
        macro_file = open(macro_path)
        macro_lines = macro_file.readlines()
        pattern = self.pattern_handler.find_vars(str(macro_lines))
        values = []
        for item in pattern:
            values.append(input("Insert value for variable " + item + ": "))
        value_filled_macro = []
        for line in macro_lines:
            value_filled_macro.append(self.pattern_handler.pattern(line ,pattern, values))
        line_num = 0
        for line in value_filled_macro:
            line_num+=1
            args = line.split()
            if args[0] == PRESS and len(args) >= 2:
                pyautogui.press(args[1])
            elif args[0] == HOTKEY and len(args) >= 2:
                pyautogui.hotkey(args[1:])
            elif args[0] == KEYBOARD and len(args) >= 2:
                partial = args[1:]
                for writing in partial:
                    pyautogui.write(writing + " ")
            elif args[0] == CLICK:
                if len(args) == 1:
                    pyautogui.click()
                elif len(args == 3):
                    pyautogui.click(args[1],args[2])
            elif args[0] == SUBPROCESS:
                stripped = " ".join(args[1:])
                output = subprocess.getoutput([stripped])
                for line in iter(output, ""):
                    print(line)
            elif args[0] == SHELL:
                subprocess.run(args[1:])
            elif args[0] == REMOTE:
                host = args[1].strip()
                user = args[2].strip()
                passd = args[3].strip()
                client = pm.SSHClient()
                client.set_missing_host_key_policy(pm.AutoAddPolicy())
                client.connect(host, username=user, password=passd)
                stdin, stdout, stderr = client.exec_command(" ".join(args[4:]), get_pty=True)
                for line in iter(stdout.readline, ""):
                    print(host + ": "+ line)
                client.close()
                stdout.close()
            elif args[0] == REMOTE_SUBPROCESS:
                endstring = args[5].strip()
                host = args[1].strip()
                user = args[2].strip()
                passd = args[3].strip()
                app = args[4].strip()
                client = pm.SSHClient()
                client.set_missing_host_key_policy(pm.AutoAddPolicy())
                client.connect(host, username=user, password=passd)
                stdinalt, stdoutalt, stderralt = client.exec_command(app, get_pty=True)
                stdinalt.write(" ".join(args[5:]) + "\n")
                for line in iter(stdoutalt.readline, ""):
                    print(host + ": "+ line)
                    if endstring in line:
                        break
                client.close()
                stdoutalt.close()
            elif args[0] == SCRAPE_FILES:
                scrape_path = args[1]
                pass_start = args[2]
                pass_end = args[3]
                fail_start = args[4]
                fail_end = args[5]
                norun_start = args[6]
                norun_end = args[7]
                curr_dir = os.getcwd()
                os.chdir(scrape_path)
                self.results_handler.scrape_files(os.listdir(scrape_path), pass_start, pass_end, fail_start, fail_end, norun_start, norun_end)
                os.chdir(curr_dir)
            elif args[0] == PRINT_RESULTS:
                print(self.results_handler.show_results())
            elif args[0] == CLEAR:
                self.results_handler.clear()
            elif args[0] == IF_TRIGGER:
                result_file = args[4]
                result_path = args[3]
                macro_path = args[2]
                condition = args[1]
                if self.pattern_handler.find_most_recent_with(result_path, result_file, condition):
                    self.read_macro(macro_path)
            elif args[0] == IF_NOT_TRIGGER:
                result_file = args[4]
                result_path = args[3]
                macro_path = args[2]
                condition = args[1]
                if not self.pattern_handler.find_most_recent_with(result_path, result_file, condition):
                    self.read_macro(macro_path)
            elif args[0] == EXPORT_ENV:
                env_key = args[1]
                env_val = args[2]
                os.putenv(env_key, env_val)
            elif args[0] == PROMPT:
                message = " ".join(args[1:])
                input(message)
            else:
                print("Invalid syntax at line " + str(line_num) + "")
                print("Actual: " + line)
                print("Expecting: <"+ PRESS + "/" + KEYBOARD + "/" + HOTKEY + "/" + CLICK + "/" + ">\t<Key/Text/coordinate>\t<key/coordinate>...")

    def _prompt_command_(command, prompt_text, multiple=False, starting_command=False, first_prompt=""):
                macro_text = command + "\t"
                if starting_command:
                    macro_text += input(first_prompt) + "\t"
                done = False
                while(not done):
                    command = input(prompt_text)
                    if not multiple:
                        done = True
                    if command != "DONE":
                        macro_text += "\t" + command
                    else:
                        done = True
                macro_text += "\n"
                return macro_text

    def _prompt_options_(command, prompt_list):
        macro_text = command + "\t"
        for prompt in prompt_list:
            macro_text += input(prompt) + "\t"
        return macro_text
        

    def create_macro(self, macro_path):
        macro_text = ""
        SCRAPE_PROMPTS = ["Enter path of files you wish to scrape results from: ","Enter text that begins in files before a passing test name: ","Enter text that comes after a passing test name: ", "Enter text that begins in files before a failing test name: ","Enter text that comes after a failing test name: ", "Enter text that begins in files before a test name that wasnt run: ", "Enter text that comes after a test name that wasnt run: "]
        IF_PROMPTS = ["Enter string that will trigger the next macro: ","Enter path of macro to be run: ","Enter path to find most recent result in: ","Enter result file: "]
        IF_NOT_PROMPTS = ["Enter string that when not present will trigger the next macro: ","Enter path of macro to be run: ","Enter path to find most recent result in: ","Enter result file: "]
        ENV_PROMPTS = ["Enter exported variable name: ","Enter exported variable value, such as a path: "]
        commands = ["press of a key","keyboard text input","mouse click","key combos","tradefed or threaded program", "shell commands","remote shell commands","remote tradefed or threaded program","scrape results from result files", "print results so far", "clear results so far", "trigger another macro on finding text","trigger another macro on NOT finding text", "set an export on terminal","prompt user to do something","DONE making macro"]
        fully_done = False
        while(not fully_done):
            command_index = 1
            for command_choice in commands:
                print(str(command_index) + ": " + command_choice)
                command_index += 1
            command = input("Enter a choice from above: ")
            if not str.isdigit(command) or int(command) > len(commands) or int(command) < 1:
                print("Invalid number, retry...")
                self.create_macro(macro_path)
            if command == "1":
                macro_text += self._prompt_command_(PRESS, "Enter key name to press: ")
            elif command ==  "2":
                macro_text += self._prompt_command_(KEYBOARD, "Enter text to send to keyboard: ")
            elif command == "3":
                macro_text += CLICK
                command = input("Enter x pixels for location of click or none for current location: ")
                if command != "none":
                    macro_text += "\t" + command
                    command = input("Enter y pixels for location of click: ")
                    macro_text += "\t" + command + "\n"
            elif command == "4":
                macro_text += self._prompt_command_(HOTKEY, "Enter key names to combine or DONE to finish: ", True)
            elif command == "5":
                macro_text += self._prompt_command_(SUBPROCESS, "Enter commands to pass or DONE to finish: ", True, True, "Enter the software to be passed args")
            elif command == "6":
                macro_text += self._prompt_command_(SHELL, "Enter shell command or DONE to finish: ", True)
            elif command == "7":
                macro_text += self._prompt_command_(REMOTE, "Enter commands to remotely or DONE to finish: ", True, True, "Enter ip address of machine you wish to remote into: ")
            elif command == "8":
                macro_text += REMOTE_SUBPROCESS
                next_ip = input("Enter ip address of machine you wish to remote into: ")
                macro_text += "\t" + next_ip
                next_program = input("Input tradefed or other threaded progam you wish to pass commands to")
                macro_text += "\t" + next_program
                done = False
                while(not done):
                    command = input("Enter commands to remotely or DONE to finish: ")
                    if command != "DONE":
                        macro_text += "\t" + command
                    else:
                        done = True
                macro_text += input("Enter the line that will occur when your subprocess/tradefed ends") + "\t"
                macro_text += "\n"
            elif command == "9":
                macro_text += self._prompt_options_(SCRAPE_FILES, SCRAPE_PROMPTS)
            elif command == "10":
                macro_text += PRINT_RESULTS + "\n"
            elif command == "11":
                macro_text += CLEAR + "\n"
            elif command == "12":
                macro_text += self._prompt_options_(IF_TRIGGER, IF_PROMPTS)
            elif command == "13":
                macro_text += self._prompt_options_(IF_NOT_TRIGGER, IF_NOT_PROMPTS)
            elif command == "14":
                macro_text += self._prompt_options_(EXPORT_ENV, ENV_PROMPTS)
            elif command == "15":
                macro_text = self._prompt_command_(PROMPT, "Enter what you want the user to do before proceeding: ")
            elif command == len(commands):
                fully_done = True
                print("Done making macro!")
            else:
                print("invalid selection, try again")    
        print("Writing new macro to " + macro_path + "...")
        new_macro = open(macro_path + '.macro', 'w+')
        new_macro.write(macro_text)
        new_macro.close()
        print("Macro created! To run, simply use read_macro function on this file")
        

class RepoAdapter:
    def __init__(self, local_path, repo_pattern, repo_variables):
        self.local_path = local_path
        self.repo_pattern = repo_pattern
        self.repo_variables = repo_variables
        self.pattern_handler = PatternHandler()
    
    def fetch(self, args):
        repo_location = self.pattern_handler.pattern(self.repo_pattern,self.repo_variables, args)
        if os.name == 'posix':
            subprocess.call(['cp','-r',repo_location, os.path.join(self.local_path, args[0] + '_' + args[1])])
        elif os.name == 'nt':
            subprocess.call(['xcopy','/s/e/i/d/Y',repo_location,os.path.join(self.local_path, stb_name + '_' + build_name) ])
        else:
            print(os.name + " is not a supported OS for RepoAdapter class, exiting...")
            return

class ConfigLoader:
    def load_config(self, config_path):
        try:
            config_file = open(config_path, 'r')
            config_json = json.load(config_file)
            self.repo_pattern = config_json['repo_pattern']
            self.repo_variables = config_json['repo_variables']
            if os.name == 'nt':
                self.local_path = config_json['local_path_nt']
                self.macro_path = config_json['macro_path_nt']
            elif os.name == 'posix':
                self.local_path = config_json['local_path_posix']
                self.macro_path = config_json['macro_path_posix']
            else:
                self.local_path = 'none'
                self.macro_path = 'none'
                print(os.name + ' is not a supported os in config files')
        except:
            print("Config file at" + config_path + " doesn't exist")

class TestingCompanion:
    def __init__(self, config_path):
        self.config_loader = ConfigLoader()
        self.config_loader.load_config(config_path)
        self.repo = RepoAdapter(self.config_loader.local_path, self.config_loader.repo_pattern, self.config_loader.repo_variables)
        self.macro_path = self.config_loader.macro_path
        self.local_path = self.config_loader.local_path
        if not os.path.exists(self.macro_path):
            if os.name == 'posix' or os.name == 'nt':
                subprocess.call(['mkdir', self.macro_path])
            else:
                print("Unable to create missing Macro directory, " + os.name + " OS unsupported")
                return
        if not os.path.exists(self.local_path):
            if os.name == 'posix' or os.name == 'nt':
                print(self.local_path)
                subprocess.call(['mkdir',self.config_loader.local_path])
            else:
                print("Unable to create missing Macro directory, " + os.name + " OS unsupported")
                return
        self.macro_handler = MacroHandler()

    def main_menu(self):
        print('Welcome to DavesSTBTesterTools Version 2.0!')
        command = input('1. Run a Macro File\n2. Create a Macro File\n3. Fetch STB from repo\n4. Exit\nEnter a number from above: ')
        if not str.isdigit(command) or int(command) > 5 or int(command) < 1:
            print("Invalid number, retry...")
            self.main_menu() 
        elif command == "1":
            print('Current Macros:')
            dirlist = os.listdir(self.macro_path)
            macros = []
            index = 0
            for macro in dirlist:
                if ".macro" in macro:
                    print(str(index) + ": " + macro)
                    index += 1
                    macros.append(macro)
            chosen_macro = input('Enter index of macro to run: ')
            if(not chosen_macro.isdigit() or int(chosen_macro) < 0 or int(chosen_macro) > len(macros)):
                print("Invalid selection, retry")
                self.main_menu()
            else:
                self.macro_handler.read_macro(os.path.join(self.macro_path,macros[int(chosen_macro)]))
                self.main_menu()
        elif command == "2":
            macro_name = input('Enter name of new macro: ')
            self.macro_handler.create_macro(os.path.join(self.macro_path, macro_name))
            self.main_menu()
        elif command == "3":
            in_variables = []
            for prompt_item in self.repo.repo_variables:
                in_variables.append(input('Enter ' + prompt_item + " of pattern: "))
            self.repo.fetch(in_variables)
            self.main_menu()
        elif command == "4":
            return
        else:
            print("invalid selection, try again")
            self.main_menu()

def main():
    test_companion = TestingCompanion(os.path.join(".","CONFIG","v2config.json"))
    test_companion.main_menu()
    
if __name__ == "__main__":
    main()



