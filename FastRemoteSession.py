import subprocess
import json
import os

def connect_session(ip, username, userpass):
    putty_process = subprocess.call("putty " + ip + " -l " + username + " -pw " + userpass)
    

def load_config():
    try:
        config_file = open(os.path.join(os.getcwd(), 'CONFIG', 'ips.json'))
        json_dict = json.load(config_file)
        return (json_dict["ips"], json_dict["username"], json_dict["userpass"])
    except:
        print("No valid ips.json was found in CONFIG folder, replace or create this file")
        return ([],"","")
def menu(ips):
    index = 1
    for ip in ips:
        print(str(index) + ": " + str(ip))
        index+= 1
    selection = input("Enter an selection: ")
    if not str.isnumeric(selection) or int(selection) > len(ips) or int(selection) < 1:
        print("Invalid selection, retry")
        menu(ips)
    return ips[int(selection)]

def main():
    ips, username, userpass = load_config()
    ip_selected = menu(ips)
    connect_session(ip_selected, username, userpass)


if __name__ == "__main__":
    main()