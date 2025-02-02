from PIL import Image
import os, sys

path = 'C:/Users/richa/Desktop/ComfyUI_windows_portable/ComfyUI/output'

def retain_most_recent(path="."):
    def pad_left(v, l):
        return "0" * (l - len(str(v))) + str(v)
    
    base_names = []
    for file in [f for f in os.listdir(path) if f.endswith("_.png")]:
        base_names.append("_".join(file.split("_")[:-2]))
    for base_name in set(base_names):
        print("=", base_name, "=")
        files = []
        index = 1
        current_name = base_name + "_"+pad_left(index, 5)+"_.png"
        while os.path.exists(os.path.join(path, current_name)):
            files.append(current_name)
            index += 1
            current_name = base_name + "_"+pad_left(index, 5)+"_.png"
        if len(files) > 1:
            files.sort()
            for file in files[:-1]:
                print("Removing", file)
                os.remove(os.path.join(path, file))
            print("Retaining", files[-1], "as", base_name + "_00001_.png")
            os.rename(os.path.join(path, files[-1]), os.path.join(path, base_name + "_00001_.png"))

if __name__ == "__main__":
    if len(sys.argv) < 2:
        retain_most_recent()
    else:
        retain_most_recent(sys.argv[1])
