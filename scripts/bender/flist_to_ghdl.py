#!/usr/bin/env python

"""
flist_to_ghd.py: 
This file is intended to take the output of the bender file  from the command:

``` bash
Bender flist
```

Where the sources within the bender scrip have the following format 

``` bender
    - tags [rtl]
    - files:
      - src/test.vhd
```

The output will have the tag et the top of the files under the files tag.

The aim of this file sis to concert this output into a format that is compatible with GHDL, 
using ghdl library mapping with the assosiated tag from the bender file.

"""

__author__      = "James Fleeting"
__copyright__   = "Copyright 2025"
__license__ = "GPL"
__version__ = "0.0.1"
__maintainer__ = "James Fleeting"
__email__ = " "
__status__ = "Development"

# Import necessary modules
import os
import sys

def get_library_name_from_tag(flist_path: str, ghdl_flist_path: str) -> str:
    """
    Extract the library name from a given file path based on its tag.

    Parameters
    ----------
    file_path : str
        The path of the file containing the tag.

    Returns
    -------
    str
        The extracted library name.
    """
    with open(flist_path, 'r', encoding='utf-8') as infile, open(ghdl_flist_path, 'w', encoding='utf-8') as outfile:
        library_name = None
        for line in infile:
            stripped_line = line.strip()
            if stripped_line.endswith(']') and 'tags [' in stripped_line:
                # Extract the tag
                library_name = stripped_line.split('[')[1].split(']')[0].strip()
                outfile.write(f'mkdir -p build/{library_name}\n')


def parse_flist_to_ghdl(flist_path: str, ghdl_flist_path: str) -> None:
    """
    Convert a Bender flist file to a GHDL-compatible format.

    Parameters
    ----------
    flist_path : str
        Path to the input Bender flist file.
    ghdl_flist_path : str
        Path to the output GHDL-compatible flist file.
    """
    with open(flist_path, 'r', encoding='utf-8') as infile, open(ghdl_flist_path, 'a', encoding='utf-8') as outfile:
        current_tag = None
        for line in infile:
            stripped_line = line.strip()
            if stripped_line.endswith(']') and 'tags [' in stripped_line:
                # Extract the tag
                current_tag = stripped_line.split('[')[1].split(']')[0].strip()
            elif stripped_line.endswith('-'):
                continue  # Skip the files line
            elif stripped_line.endswith('.vhd') or stripped_line.endswith('.vhdl'):
                # This is a file entry
                file_path = stripped_line[1:].strip()
                if current_tag:
                    outfile.write(f'ghdl -a --std=08 --work={current_tag} --workdir=build/{current_tag} /{file_path}\n')
    
if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python flist_to_ghdl.py <input_flist> <output_ghdl_flist>")
        sys.exit(1)

    input_flist = sys.argv[1]
    output_ghdl_flist = sys.argv[2]

    get_library_name_from_tag(input_flist, output_ghdl_flist)
    parse_flist_to_ghdl(input_flist, output_ghdl_flist)
    print(f"Converted {input_flist} to GHDL format at {output_ghdl_flist}")
