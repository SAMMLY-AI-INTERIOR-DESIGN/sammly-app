import os
import re

lib_dir = "lib"

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    orig = content
    
    # Remove const from some widgets
    content = content.replace("const NoDataWidget", "NoDataWidget")
    content = content.replace("const CustomAppbar", "CustomAppbar")
    
    # Remove const from lists of strings that start with S.of
    content = re.sub(r'const\s+\[\s*S\.of\(context\)', '[S.of(context)', content)
    
    if "generate_mappers.dart" in filepath:
        content = content.replace("S.of(context)", "S.current")

    if orig != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Fixed {filepath}")

for root, dirs, files in os.walk(lib_dir):
    for f in files:
        if f.endswith('.dart'):
            process_file(os.path.join(root, f))
