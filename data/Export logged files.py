import json,os

with open('../out.txt', 'r') as f:
    data = json.load(f)

for key, value in data.items():
    file = key.lstrip("\\")
    print("Exported:", key.lstrip("\\"))
    
    directory = os.path.dirname(key.lstrip("\\"))
    
    if directory != "":
        os.makedirs(directory, exist_ok=True)

    with open(file, 'w') as f:
        f.write(value)
