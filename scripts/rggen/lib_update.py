import pathlib
import re

# Configuration
ROOT_DIR = pathlib.Path("out/")
VHDL_EXTENSIONS = {".vhd", ".vhdl"}

USE_REPLACEMENT = (
    "library rggen_rtl;\n"
    "use rggen_rtl.rggen_rtl.all;"
)

USE_PATTERN = re.compile(
    r'^\s*use\s+work\.rggen_rtl\.all\s*;\s*$',
    re.IGNORECASE | re.MULTILINE
)

WORK_LIB_PATTERN = re.compile(r'\bwork\.', re.IGNORECASE)


def process_file(file_path: pathlib.Path) -> None:
    original_text = file_path.read_text(encoding="utf-8")
    updated_text = original_text

    # Replace the specific use clause
    updated_text = USE_PATTERN.sub(USE_REPLACEMENT, updated_text)

    # Replace remaining work.* references
    updated_text = WORK_LIB_PATTERN.sub("rggen_rtl.", updated_text)

    if updated_text != original_text:
        file_path.write_text(updated_text, encoding="utf-8")
        print(f"Updated: {file_path}")


def main():
    for path in ROOT_DIR.rglob("*"):
        if path.suffix.lower() in VHDL_EXTENSIONS:
            process_file(path)


if __name__ == "__main__":
    main()
