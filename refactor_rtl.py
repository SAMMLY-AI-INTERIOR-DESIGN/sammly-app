import os
import re

lib_dir = "lib"

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original_content = content

    # 1. RTL Layout replacements
    content = content.replace("Alignment.centerLeft", "AlignmentDirectional.centerStart")
    content = content.replace("Alignment.centerRight", "AlignmentDirectional.centerEnd")
    content = content.replace("Alignment.bottomLeft", "AlignmentDirectional.bottomStart")
    content = content.replace("Alignment.bottomRight", "AlignmentDirectional.bottomEnd")
    content = content.replace("Alignment.topLeft", "AlignmentDirectional.topStart")
    content = content.replace("Alignment.topRight", "AlignmentDirectional.topEnd")
    content = content.replace("TextAlign.left", "TextAlign.start")
    content = content.replace("TextAlign.right", "TextAlign.end")

    # Replace EdgeInsets.only
    def edge_insets_replacer(match):
        inner = match.group(1)
        inner = re.sub(r'\bleft\s*:', 'start:', inner)
        inner = re.sub(r'\bright\s*:', 'end:', inner)
        return f"EdgeInsetsDirectional.only({inner})"
    content = re.sub(r'EdgeInsets\.only\(([^)]*)\)', edge_insets_replacer, content)

    # Replace EdgeInsets.fromLTRB
    def edge_insets_ltrb_replacer(match):
        l, t, r, b = match.group(1), match.group(2), match.group(3), match.group(4)
        return f"EdgeInsetsDirectional.fromSTEB({l}, {t}, {r}, {b})"
    content = re.sub(r'EdgeInsets\.fromLTRB\(([^,]+),\s*([^,]+),\s*([^,]+),\s*([^)]+)\)', edge_insets_ltrb_replacer, content)

    # Replace Positioned
    def positioned_replacer(match):
        inner = match.group(1)
        inner = re.sub(r'\bleft\s*:', 'start:', inner)
        inner = re.sub(r'\bright\s*:', 'end:', inner)
        return f"PositionedDirectional({inner})"
    content = re.sub(r'Positioned\(([^)]*)\)', positioned_replacer, content)

    # 2. AppStrings replacements
    if "AppStrings." in content and not filepath.endswith("app_strings.dart"):
        content = re.sub(r'AppStrings\.([a-zA-Z0-9_]+)', r'S.of(context).\1', content)
        
        # Add import if missing
        if "package:sammly/generated/l10n.dart" not in content:
            # Find the last import statement
            import_matches = list(re.finditer(r'^import\s+[\'"].*?[\'"];\n?', content, re.MULTILINE))
            if import_matches:
                last_import = import_matches[-1]
                insert_pos = last_import.end()
                content = content[:insert_pos] + "import 'package:sammly/generated/l10n.dart';\n" + content[insert_pos:]
            else:
                content = "import 'package:sammly/generated/l10n.dart';\n" + content

    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated {filepath}")

for root, _, files in os.walk(lib_dir):
    for file in files:
        if file.endswith(".dart"):
            process_file(os.path.join(root, file))

print("Done.")
