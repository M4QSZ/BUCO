import os
import hashlib
import re
import shutil

project_root = r'c:\Users\Miguel\Documents\flutter\BUCO'
media_folder = 'assets/media'
absolute_media_folder = os.path.join(project_root, 'assets', 'media')

ignore_dirs = {'.git', '.dart_tool', 'build', 'windows', 'linux', 'macos', 'android', 'ios', 'web', 'test'}
extensions = {'.png', '.jpg', '.jpeg', '.svg'}

# 1. Collect all assets and their hashes
file_hashes = {}
old_to_new_path = {}
unique_files = {}

if not os.path.exists(absolute_media_folder):
    os.makedirs(absolute_media_folder)

for root, dirs, files in os.walk(project_root):
    # filter ignored dirs
    dirs[:] = [d for d in dirs if d not in ignore_dirs and not d.startswith('.')]
    
    # Do not process the new media folder itself
    if os.path.abspath(root) == os.path.abspath(absolute_media_folder):
        continue
        
    for file in files:
        ext = os.path.splitext(file)[1].lower()
        if ext in extensions:
            filepath = os.path.join(root, file)
            # relative path with forward slashes
            rel_path = os.path.relpath(filepath, project_root).replace('\\', '/')
            
            with open(filepath, 'rb') as f:
                content = f.read()
                filehash = hashlib.md5(content).hexdigest()
            
            if filehash not in unique_files:
                # Decide new name
                clean_name = re.sub(r'[^a-zA-Z0-9_\-\.]', '_', file).lower()
                new_filename = f"{filehash[:6]}_{clean_name}"
                new_rel_path = f"{media_folder}/{new_filename}"
                unique_files[filehash] = {
                    'old_path': filepath,
                    'new_path': os.path.join(project_root, new_rel_path),
                    'new_rel_path': new_rel_path
                }
            
            old_to_new_path[rel_path] = unique_files[filehash]['new_rel_path']
            # Sometimes paths in dart omit the root if it's strange, but usually it matches
            # Let's also map the basename just in case we need a fallback, though risky.

# 2. Copy unique files to the new folder
print(f"Found {len(old_to_new_path)} asset files, {len(unique_files)} unique.")
for data in unique_files.values():
    shutil.copy2(data['old_path'], data['new_path'])

# 3. Update all .dart files
dart_files = []
for root, dirs, files in os.walk(os.path.join(project_root, 'lib')):
    for file in files:
        if file.endswith('.dart'):
            dart_files.append(os.path.join(root, file))

# We should also check what paths are actually in the dart files.
# For each dart file, we find all strings ending in .svg, .png, etc.
path_pattern = re.compile(r"['\"]([^'\"]+\.(?:svg|png|jpg|jpeg))['\"]", re.IGNORECASE)

for dart_file in dart_files:
    try:
        with open(dart_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        new_content = content
        # Find all matches
        matches = path_pattern.findall(content)
        for match in matches:
            if match.startswith('http://') or match.startswith('https://'):
                continue
            
            clean_match = match.lstrip('/')
            
            # Try to find exactly
            if clean_match in old_to_new_path:
                new_content = new_content.replace(match, old_to_new_path[clean_match])
            else:
                # Try to match by basename if exact match fails
                basename = os.path.basename(clean_match)
                possible_keys = [k for k in old_to_new_path.keys() if k.endswith(basename)]
                if len(possible_keys) == 1:
                    new_content = new_content.replace(match, old_to_new_path[possible_keys[0]])
                elif len(possible_keys) > 1:
                    print(f"Ambiguous match for {clean_match} in {dart_file}")
                else:
                    print(f"Could not find replacement for {clean_match} in {dart_file}")
                    
        if new_content != content:
            with open(dart_file, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Updated {dart_file}")
    except Exception as e:
        print(f"Failed to process {dart_file}: {e}")

# 4. Update pubspec.yaml
pubspec_path = os.path.join(project_root, 'pubspec.yaml')
with open(pubspec_path, 'r', encoding='utf-8') as f:
    pubspec = f.read()

# Replace all assets: lines
# We will just replace the whole assets: block with the new one
if 'assets:' in pubspec:
    # simple replacement for the assets block
    # We will use regex to find assets: and all following list items, and replace with assets: - assets/media/
    pubspec = re.sub(r'assets:\n(?:\s+- .*\n)*', f'assets:\n    - {media_folder}/\n', pubspec)
    with open(pubspec_path, 'w', encoding='utf-8') as f:
        f.write(pubspec)
    print("Updated pubspec.yaml")

# 5. Delete old files and empty folders? (Optional, let's just delete the known old files)
# For safety, we only delete the old files, we don't delete folders yet.
for old_path in old_to_new_path.keys():
    abs_old_path = os.path.join(project_root, old_path)
    if os.path.exists(abs_old_path):
        try:
            os.remove(abs_old_path)
        except:
            pass
