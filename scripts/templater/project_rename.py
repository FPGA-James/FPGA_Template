"""
Utility for recursively searching through files in a directory and replacing
all occurrences of a text placeholder. Also supports renaming files whose names
contain the placeholder token.

The script writes a configuration marker file named ``.project_setup_complete``
into the directory from which the script is invoked (the current working
directory).
"""

import os
import sys


def replace_in_file(filepath: str, placeholder: str, replacement: str) -> None:
    """
    Replace occurrences of a placeholder in a single file.

    This function reads the file as UTF-8 text, replaces all occurrences of
    ``placeholder`` with ``replacement``, and writes the updated content back
    to disk.

    Parameters
    ----------
    filepath : str
        Path to the file to be processed.
    placeholder : str
        The text token to search for.
    replacement : str
        The value used to replace the placeholder.

    Raises
    ------
    UnicodeDecodeError
        Raised if the file cannot be decoded as UTF-8.
    """
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    if placeholder in content:
        new_content = content.replace(placeholder, replacement)
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"Updated file contents: {filepath}")


def rename_file_if_needed(dirpath: str, filename: str, placeholder: str, replacement: str) -> None:
    """
    Rename a file if its filename contains the placeholder token.

    Parameters
    ----------
    dirpath : str
        The directory containing the file.
    filename : str
        The file name before renaming.
    placeholder : str
        The placeholder to search for in the filename.
    replacement : str
        The replacement value.
    """
    if placeholder in filename:
        new_name = filename.replace(placeholder, replacement)
        old_path = os.path.join(dirpath, filename)
        new_path = os.path.join(dirpath, new_name)

        os.rename(old_path, new_path)
        print(f"Renamed file: {old_path} -> {new_path}")


def search_and_replace(root_path: str, placeholder: str, replacement: str) -> None:
    """
    Recursively search a directory and replace a placeholder in file contents
    and filenames.

    After processing, the sentinel file ``.project_setup_complete`` is created
    inside the directory from which the script is executed.

    Parameters
    ----------
    root_path : str
        Directory to traverse for placeholder replacement.
    placeholder : str
        The placeholder token to search for.
    replacement : str
        The replacement value.
    """
    for dirpath, _, filenames in os.walk(root_path):
        for filename in filenames:
            full_path = os.path.join(dirpath, filename)

            try:
                replace_in_file(full_path, placeholder, replacement)
            except UnicodeDecodeError:
                pass  # Skip non-text files

            rename_file_if_needed(dirpath, filename, placeholder, replacement)

    # Create marker in CURRENT WORKING DIRECTORY
    marker_path = os.path.join(os.getcwd(), ".project_setup_complete")
    with open(marker_path, "w", encoding="utf-8") as f:
        f.write("setup complete\n")

    print(f"Created marker file: {marker_path}")


def main() -> None:
    """
    Command-line interface for the replacement utility.

    The function checks whether ``.project_setup_complete`` exists in the
    current working directory. If it exists, the script exits immediately.

    If not present, the script performs placeholder replacements in both file
    content and filenames inside the specified directory, and then creates the
    marker file in the current working directory.
    """
    if len(sys.argv) != 3:
        print("Usage: python replace_name.py <directory> <replacement>")
        sys.exit(1)

    directory = sys.argv[1]
    replacement_value = sys.argv[2]

    # Marker always lives in the CWD
    marker_path = os.path.join(os.getcwd(), ".project_setup_complete")

    if os.path.exists(marker_path):
        print("The project has already been configured.")
        sys.exit(0)

    search_and_replace(directory, "<<NAME>>", replacement_value)


if __name__ == "__main__":
    main()
