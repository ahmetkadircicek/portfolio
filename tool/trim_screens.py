"""Trims the transparent edges off every project screenshot, in place.

Screenshots are flat phone screens; covers and grids size them by their
own edges, so a transparent margin would shrink a screen next to the
others. Run it again after adding screenshots:

    python3 -m pip install pillow
    python3 tool/trim_screens.py

Prints each file's size and aspect ratio (width / height) afterwards;
every screen should be close to the others (about 0.49).
"""

import pathlib
import sys

from PIL import Image

ROOT = pathlib.Path(__file__).resolve().parent.parent
SCREENS = sorted(ROOT.glob("assets/images/*/*_screenshots_*.webp"))


def trim(path: pathlib.Path) -> tuple[int, int, bool]:
    image = Image.open(path)
    image.load()
    box = image.getchannel("A").getbbox() if image.mode == "RGBA" else None
    changed = box is not None and box != (0, 0, *image.size)
    if changed:
        image = image.crop(box)
        image.save(path, "WEBP", quality=90, method=6)
    return (*image.size, changed)


def main() -> int:
    if not SCREENS:
        print("no screenshots found", file=sys.stderr)
        return 1
    for path in SCREENS:
        width, height, changed = trim(path)
        mark = "trimmed" if changed else "kept"
        print(f"{path.relative_to(ROOT)}  {width}x{height}  {width / height:.3f}  {mark}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
