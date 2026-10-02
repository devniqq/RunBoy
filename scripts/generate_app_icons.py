#!/usr/bin/env python3

import json
import os
import sys
from pathlib import Path

try:
    from PIL import Image, ImageDraw, ImageFont, ImageFilter
except ImportError:
    print("Pillow is required. Install it with: python3 -m pip install pillow")
    sys.exit(1)

ROOT = Path(__file__).resolve().parent.parent
ASSET_DIR = ROOT / "Assets.xcassets" / "AppIcon.appiconset"
ASSET_DIR.mkdir(parents=True, exist_ok=True)

icon_sizes = {
    "AppIcon-20@2x.png": 40,
    "AppIcon-20@3x.png": 60,
    "AppIcon-29@2x.png": 58,
    "AppIcon-29@3x.png": 87,
    "AppIcon-40@2x.png": 80,
    "AppIcon-40@3x.png": 120,
    "AppIcon-60@2x.png": 120,
    "AppIcon-60@3x.png": 180,
    "AppIcon-76.png": 76,
    "AppIcon-76@2x.png": 152,
    "AppIcon-83.5@2x.png": 167,
    "AppIcon-1024.png": 1024,
}


def draw_icon(size: int, path: Path):
    bg = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(bg)

    margin = max(10, int(size * 0.11))
    radius = max(20, int(size * 0.2))
    x0, y0 = margin, margin
    x1, y1 = size - margin, size - margin

    # Gradient background
    for y in range(size):
        t = y / max(size - 1, 1)
        r = int(28 + t * 70)
        g = int(80 + t * 70)
        b = int(180 + t * 44)
        color = (r, g, b, 255)
        draw.line((0, y, size, y), fill=color)

    # Rounded rectangle background
    overlay = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    overlay_draw = ImageDraw.Draw(overlay)
    overlay_draw.rounded_rectangle((x0, y0, x1, y1), radius=radius, fill=(18, 22, 31, 255))
    bg = Image.alpha_composite(bg, overlay)

    # Accent stripe
    stripe = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    stripe_draw = ImageDraw.Draw(stripe)
    stripe_draw.rounded_rectangle((margin, margin, size - margin, size - margin), radius=radius, outline=(255, 221, 70, 200), width=max(3, size // 40))
    bg = Image.alpha_composite(bg, stripe)

    # Add a stylized R mark
    try:
        font_path = "/System/Library/Fonts/Supplemental/Arial Bold.ttf"
        if not os.path.exists(font_path):
            font_path = "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
        font = ImageFont.truetype(font_path, size=max(42, size // 2))
    except Exception:
        font = ImageFont.load_default()

    letter = "R"
    bbox = font.getbbox(letter)
    text_w = bbox[2] - bbox[0]
    text_h = bbox[3] - bbox[1]
    x = (size - text_w) / 2
    y = (size - text_h) / 2 - size * 0.03
    draw = ImageDraw.Draw(bg)
    draw.text((x, y), letter, font=font, fill=(255, 255, 255, 255))

    bg = bg.filter(ImageFilter.GaussianBlur(radius=0.3))
    bg.save(path)


for filename, size in icon_sizes.items():
    draw_icon(size, ASSET_DIR / filename)

contents = {
    "images": [],
    "info": {"author": "xcode", "version": 1}
}

for filename, size in icon_sizes.items():
    info = {"idiom": "iphone", "size": "", "scale": "1x"}
    if filename.endswith("@2x.png"):
        info["scale"] = "2x"
        base = filename.replace("@2x.png", "")
    elif filename.endswith("@3x.png"):
        info["scale"] = "3x"
        base = filename.replace("@3x.png", "")
    else:
        base = filename.replace(".png", "")

    if base.endswith("-1024"):
        info["idiom"] = "ios-marketing"
        info["scale"] = "1x"
        info["size"] = "1024x1024"
    else:
        # Remove leading "AppIcon-" if present
        size_part = base.replace("AppIcon-", "")
        if "@" in size_part:
            size_part = size_part.split("@", 1)[0]
        if "." in size_part:
            size_part = size_part.split(".", 1)[0]
        info["size"] = f"{size_part}x{size_part}"
        if "83.5" in filename:
            info["size"] = "83.5x83.5"

    if base == "AppIcon-20" and filename.endswith("@2x.png"):
        info["size"] = "20x20"
    if base == "AppIcon-20" and filename.endswith("@3x.png"):
        info["size"] = "20x20"
    if base == "AppIcon-29" and filename.endswith("@2x.png"):
        info["size"] = "29x29"
    if base == "AppIcon-29" and filename.endswith("@3x.png"):
        info["size"] = "29x29"
    if base == "AppIcon-40" and filename.endswith("@2x.png"):
        info["size"] = "40x40"
    if base == "AppIcon-40" and filename.endswith("@3x.png"):
        info["size"] = "40x40"
    if base == "AppIcon-60" and filename.endswith("@2x.png"):
        info["size"] = "60x60"
    if base == "AppIcon-60" and filename.endswith("@3x.png"):
        info["size"] = "60x60"
    if base == "AppIcon-76" and filename.endswith(".png"):
        info["size"] = "76x76"
    if base == "AppIcon-76" and filename.endswith("@2x.png"):
        info["size"] = "76x76"
    if base == "AppIcon-83.5" and filename.endswith("@2x.png"):
        info["size"] = "83.5x83.5"

    if filename.endswith("@3x.png"):
        info["scale"] = "3x"
    elif filename.endswith("@2x.png"):
        info["scale"] = "2x"
    elif filename.endswith(".png"):
        info["scale"] = "1x"

    info["filename"] = filename
    contents["images"].append(info)

(ASSET_DIR / "Contents.json").write_text(json.dumps(contents, indent=2))
print(f"Generated placeholder app icons in: {ASSET_DIR}")
