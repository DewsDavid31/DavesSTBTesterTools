import os
import xml.etree.ElementTree as ET

def rename_results_folder(nested_path):
    for folder in os.listdir(nested_path):
        new_name = strip_name_data(folder)
        rename_folder(folder, new_name)

def strip_name_data(folder_path):
    curr_dir = os.getcwd()
    os.chdir(folder_path)
    xml_file = open(os.path.join(folder_path, "test_result.xml"), 'r')
    oldname = folder_path.split("/")[-2]
    root_xml = ET.parse(xml_file)
    build_element = ET.find("Build").attrib
    suite_element = ET.getroot().attrib
    module_element = ET.find("Module").attrib
    build = build_element["build_fingerprint"].split("/")[3].split(".")[0]
    suite = suite_element["suite_name"]
    device = build_element["build_device"][3:]
    module = module_element["name"]
    new_name = device + "_" + build + "_" + suite + "_" + module + "_" + oldname
    os.chdir(curr_dir)
    return new_name

def rename_folder(folder_path, new_name):
    new_path = "/".join(folder_path.split("/")[-1:]) + new_name
    os.rename(folder_path, new_path)

def main():
    selected_path = input("Enter path of tradefed results you wish to autorename: ")
    if not os.path.exists(selected_path):
        print("this path doesn't exist, retry")
        main()
    rename_results_folder(selected_path)
    print("done!")