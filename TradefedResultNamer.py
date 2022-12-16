import os
import xml.etree.ElementTree as ET

def rename_results_folder(nested_path):
    curr_dir = os.getcwd()
    os.chdir(nested_path)
    dirs_only = [d for d in os.listdir(nested_path) if os.path.isdir(d)]
    for folder in dirs_only:
        new_name = strip_name_data(folder)
        rename_folder(nested_path + "/" + folder, new_name)
    os.chdir(curr_dir)

def strip_name_data(folder_path):
    oldname = folder_path
    try:
        curr_dir = os.getcwd()
        os.chdir(folder_path)
        xml_file = open("test_result.xml", 'r')
        root_xml = ET.parse(xml_file)
        build_element = root_xml.find("Build").attrib
        suite_element = root_xml.getroot().attrib
        module_element = root_xml.find("Module").attrib
        build = build_element["build_fingerprint"].split("/")[3].split(".")[0]
        suite = suite_element["suite_name"]
        device = build_element["build_device"][3:]
        module = module_element["name"]
        new_name = device + "_" + build + "_" + suite + "_" + module + "_" + oldname
        os.chdir(curr_dir)
        return new_name
    except:
        print("unable to find test_result.xml for " + oldname)
        return oldname

def rename_folder(folder_path, new_name):
    curr_dir = os.getcwd()
    os.chdir(folder_path + "/../")
    new_path = "/".join(folder_path.split("/")[-1:]) + new_name
    os.rename(folder_path, new_path)
    if os.path.isfile(folder_path + ".zip"):
        os.rename(folder_path + ".zip", new_path + ".zip")
    os.chdir(curr_dir)

def main():
    selected_path = input("Enter path of tradefed results you wish to autorename: ")
    if selected_path[-1] != "/":
        selected_path += "/"
    if not os.path.exists(selected_path):
        print("this path doesn't exist, retry")
        main()
    rename_results_folder(selected_path)
    print("done!")