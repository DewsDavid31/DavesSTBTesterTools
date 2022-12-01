import subprocess
import os
import pyautogui
import json
PRESS = "press"
KEYBOARD = "keyboard"
CLICK = "click"
HOTKEY = "hotkey"
SUBPROCESS = "subprocess"
SHELL = "shell"


class PatternHandler:
    def pattern(self, pattern_string, variables, args):
        temp_string = pattern_string[:]
        for key, val in zip(variables,args):
            temp_string = temp_string.replace(key, val)
        return temp_string


class MacroHandler:
    def __init__(self):
        self.pattern_handler = PatternHandler()

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
                    

                    

                
    def read_macro(self, macro_path):
        macro_file = open(macro_path)
        macro_lines = macro_file.readlines()
        line_num = 0
        for line in macro_lines:
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
                process = subprocess.Popen([str(args[1:]).strip().replace('[','').replace(']','')], shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                print(process.stdout.readlines())
            elif args[0] == SHELL:
                process = subprocess.run([str(args[1:]).strip().replace('[','').replace(']','')])
            else:
                print("Invalid syntax at line " + str(line_num) + "")
                print("Actual: " + line)
                print("Expecting: <"+ PRESS + "/" + KEYBOARD + "/" + HOTKEY + "/" + CLICK + "/" + ">\t<Key/Text/coordinate>\t<key/coordinate>...")

    def read_macro_pattern(self, macro_path):
        macro_file = open(macro_path)
        macro_lines = macro_file.readlines()
        pattern = self.find_vars(str(macro_lines))
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
                process = subprocess.run([str(args[1:]).strip().replace('[','').replace(']','')], shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                print(process.stdout.readlines())
            elif args[0] == SHELL:
                process = subprocess.run([str(args[1:]).strip().replace('[','').replace(']','')])
            else:
                print("Invalid syntax at line " + str(line_num) + "")
                print("Actual: " + line)
                print("Expecting: <"+ PRESS + "/" + KEYBOARD + "/" + HOTKEY + "/" + CLICK + "/" + ">\t<Key/Text/coordinate>\t<key/coordinate>...")


    def create_macro(self, macro_path):
        macro_text = ""
        fully_done = False
        while(not fully_done):
            command = input("Enter index for type of keypress\n1. press of a key\n2. keyboard text input\n3. mouse click\n4.key combos\n5. DONE making macro\nEnter a number from above: ")
            if not str.isdigit(command) or int(command) > 6 or int(command) < 1:
                print("Invalid number, retry...")
                self.create_macro(macro_path)
                if command == "1":
                    macro_text += PRESS
                    command = input("Enter key name to press: ")
                    macro_text += "\t" + command + "\n"
                elif command ==  "2":
                    macro_text += KEYBOARD
                    command = input("Enter text to send to keyboard: ")
                    macro_text += "\t" + command + "\n"
                elif command == "3":
                    macro_text += CLICK
                    command = input("Enter x pixels for location of click or none for current location: ")
                    if command != "none":
                        macro_text += "\t" + command
                        command = input("Enter y pixels for location of click: ")
                        macro_text += "\t" + command + "\n"
                elif command == "4":
                    macro_text += HOTKEY
                    done = False
                    while(not done):
                        if command != "DONE":
                            command = input("Enter key names to combine or DONE to finish: ")
                            macro_text += "\t" + command + "\n"
                        else:
                            done = True
                elif command == "5":
                    macro_text += SUBPROCESS
                    done = False
                    first_command = input("Enter the software to be passed args")
                    macro_text += "\t" + first_command
                    while(not done):
                        if command != "DONE":
                            command = input("Enter commands to pass or DONE to finish: ")
                            macro_text += "\t" + command + "\n"
                        else:
                            done = True
                    fully_done = True
                elif command == "6":
                    macro_text += SHELL
                    done = False
                    while(not done):
                        if command != "DONE":
                            command = input("Enter commands to run in terminal or DONE to finish: ")
                            macro_text += "\t" + command + "\n"
                        else:
                            done = True
                    fully_done = True
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
        command = input('1. Run a Macro File\n2. Create a Macro File\n3. Fetch STB from repo\n4. Run a macro with variables\n5. Exit\nEnter a number from above: ')
        if not str.isdigit(command) or int(command) > 5 or int(command) < 1:
                print("Invalid number, retry...")
                self.main_menu() 
        match int(command):
            case 1:
                print('Current Macros:')
                print(os.listdir(self.macro_path))
                chosen_macro = input('Enter macro above to run: ')
                self.macro_handler.read_macro(os.path.join(self.macro_path,chosen_macro))
                self.main_menu()
            case 2:
                macro_name = input('Enter name of new macro: ')
                self.macro_handler.create_macro(os.path.join(self.macro_path, macro_name))
                self.main_menu()
            case 3:
                in_variables = []
                for prompt_item in self.repo.repo_variables:
                    in_variables.append(input('Enter ' + prompt_item + " of pattern: "))
                self.repo.fetch(in_variables)
                self.main_menu()
            case 4:
                print('Current Macros:')
                print(os.listdir(self.macro_path))
                chosen_macro = input('Enter macro above to run: ')
                self.macro_handler.read_macro_pattern(os.path.join(self.macro_path, chosen_macro))
            case 5:
                return

def main():
    test_companion = TestingCompanion(os.path.join(".","CONFIG","v2config.json"))
    test_companion.main_menu()
    
if __name__ == "__main__":
    main()



