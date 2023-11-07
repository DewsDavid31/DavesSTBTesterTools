import logging
import os
import xml.etree.ElementTree as ET


main_run_list = ["vtsfiemapwritertest","apkveritytest","assistantlatencytestbench","ctsaccessibilityservicetestcases","ctsclasspathdeviceinfotestcases","ctsabioverridehosttestcases"]

def rename_results_folder(nested_path):
    curr_dir = os.getcwd()
    os.chdir(nested_path)
    dirs_only = [d for d in os.listdir(nested_path) if os.path.isdir(d)]
    for folder in dirs_only:
        if folder == "latest":
            continue
        os.chdir(folder)
        new_name = strip_name_data(folder)
        if str.isnumeric(folder.replace('.','').replace('_','')):
            print("renaming " + folder )
            rename_folder(nested_path + "/" + folder, new_name)
        else:
            print(folder + " is already named or not in tradefed date format! skipping!")
        os.chdir(nested_path)
    os.chdir(curr_dir)

def strip_name_data(folder_path):
    oldname = folder_path
    try:
        xml_file = open("test_result.xml", 'r')
        root_xml = ET.parse(xml_file)
        build_element = root_xml.find("Build").attrib
        suite_element = root_xml.getroot().attrib
        module_element = root_xml.find("Module").attrib
        build = build_element["build_fingerprint"].split("/")[3].split(".")[0]
        suite = suite_element["suite_name"]
        device = build_element["build_serial"][:3]
        target_list = "".join(build_element["command_line_args"]).split(" ")
        if device == "HP0":
            device = "HopperPlus"
        module = module_element["name"]
        if suite.lower() == "vts" and "cts" in module.lower():
            suite = "CTSonGSI"
        if module.lower() in main_run_list:
            module = "MainRun"
        if "-t" in target_list:
            target_index = target_list.index('-t')
            target = target_list[target_index + 1]
            new_name = device + "_" + suite + "_" + build + "_" + module + "_" + target + "_" + oldname
        else:
            new_name = device + "_" + suite + "_" + build + "_" + module + "_" + oldname
        return new_name
    except:
        print("unable to find test_result.xml for " + oldname)
        return oldname

def rename_folder(folder_path, new_name):
    os.chdir(folder_path + "/../")
    new_path = "/".join(folder_path.split("/")[:-1]) + new_name
    os.rename(folder_path, new_path)
    try:
        os.rename(folder_path + ".zip", new_path + ".zip")
    except:
        print(folder_path + ".zip not found")

def main():
    preselected = ["/home/" +os.getlogin() + "/Desktop/Tools/dev_builds/android-vts/results/","/home/" +os.getlogin() + "/Desktop/Tools/dev_builds/android-gts/results/","/home/" +os.getlogin() + "/Desktop/Tools/regular_builds/android-vts/results/","/home/" +os.getlogin() + "/Desktop/Tools/regular_builds/android-gts/results/"]
    index = 0
    for selection in preselected:
        print(str(index) + ": " + selection)
        index+=1
    selected_path = input("Enter number of preselected results or enter a path: ")
    if selected_path.isdigit() and int(selected_path) > 0 and int(selected_path) <= len(preselected):
        selected_path = preselected[int(selected_path)]
    if selected_path[-1] != "/":
        selected_path += "/"
    if not os.path.exists(selected_path):
        print("this path doesn't exist, retry")
        return main()
    rename_results_folder(selected_path)
    print("done!")

if __name__ == "__main__":
    main()
