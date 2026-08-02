import os

svg_template = '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 140 140">
  <circle cx="70" cy="70" r="70" fill="{color}"/>
  <text x="70" y="75" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="white" text-anchor="middle">{name}</text>
</svg>'''

brands = [
    ('carlsjr', 'Carls Jr', '#E21A22'),
    ('littlecaesars', 'Caesars', '#FF6600'),
    ('dominos', 'Dominos', '#0055A5'),
    ('kfc', 'KFC', '#E4002B'),
    ('subway', 'Subway', '#008938'),
    ('piopio', 'Pio Pio', '#F0531C'),
    ('donlee', 'Don Lee', '#C00A27')
]

dest_dir = 'c:/Users/Miguel/Documents/flutter/BUCO/assets/media'
os.makedirs(dest_dir, exist_ok=True)

for file_name, display_name, color in brands:
    content = svg_template.format(color=color, name=display_name)
    file_path = os.path.join(dest_dir, f'logo_{file_name}.svg')
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f'Created {file_path}')
