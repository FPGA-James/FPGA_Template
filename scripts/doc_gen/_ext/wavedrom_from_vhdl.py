import re
import os
import json

# Regex to find @wavedrom ... @endwavedrom blocks
WAVEDROM_RE = re.compile(r"@wavedrom(.*?)@endwavedrom", re.DOTALL)

# Path to your VHDL sources (adjust as needed)
VHDL_SRC_DIR = os.path.abspath("../../rtl")

# Path to dump the intermediate “docstring” for debugging
DEBUG_RAT_PATH = os.path.join(os.getcwd(), "debug_rat.rst")


def find_vhdl_file(entity_name):
    """
    Return the first .vhd file containing the entity
    """
    for root, _, files in os.walk(VHDL_SRC_DIR):
        for f in files:
            if f.endswith(".vhd"):
                path = os.path.join(root, f)
                with open(path, "r") as file:
                    if f"entity {entity_name}" in file.read():
                        return path
    return None


def extract_wavedrom(app, what, name, obj, options, lines):
    """
    Scan the VHDL file for @wavedrom blocks and append as
    properly indented .. wavedrom:: directives.
    """
    print(f"DEBUG: hook called for entity '{name}', type='{what}'")

    if what != "autoentity":
        return

    vhdl_file = find_vhdl_file(name)
    if not vhdl_file:
        print(f"WARNING: VHDL file for entity '{name}' not found in {VHDL_SRC_DIR}")
        return

    print(f"DEBUG: VHDL file found: {vhdl_file}")

    with open(vhdl_file, "r") as f:
        vhdl_text = f.read()

    final_lines = []

    wavedrom_blocks = WAVEDROM_RE.findall(vhdl_text)
    if not wavedrom_blocks:
        print(f"DEBUG: No WaveDrom blocks found in {name}")
    else:
        print(f"DEBUG: Found {len(wavedrom_blocks)} WaveDrom block(s) in {name}")

    for idx, match in enumerate(wavedrom_blocks, start=1):
        print(f"DEBUG: Processing WaveDrom block {idx} for entity '{name}'")

        # Remove leading comment markers and whitespace
        content_lines = [l.lstrip("- ").lstrip() for l in match.splitlines() if l.strip()]
        json_text = "\n".join(content_lines)

        try:
            # Parse JSON and pretty-print
            json_obj = json.loads(json_text)
            pretty_json = json.dumps(json_obj, indent=4)
        except Exception:
            print(f"WARNING: Invalid JSON in WaveDrom block {idx} of '{name}', using raw text")
            pretty_json = json_text

        # Append the directive
        final_lines.append("")
        final_lines.append(".. wavedrom::")
        final_lines.append("")
        for pl in pretty_json.splitlines():
            final_lines.append(f"    {pl}")
        final_lines.append("")

    # Inject into Sphinx entity docstring
    lines.extend(final_lines)

    # Optional: debug RAT output
    try:
        os.makedirs(os.path.dirname(DEBUG_RAT_PATH), exist_ok=True)
        with open(DEBUG_RAT_PATH, "w") as f:
            f.write("\n".join(lines))
            f.write("\n")
        print(f"DEBUG: Intermediate RAT written to {DEBUG_RAT_PATH}")
    except Exception as e:
        print(f"WARNING: Could not write debug RAT file: {e}")


def setup(app):
    """
    Register the hook with Sphinx.
    """
    app.connect("autodoc-process-docstring", extract_wavedrom)
    print("DEBUG: WaveDrom autoentity hook setup complete")
    return {
        "version": "0.1",
        "parallel_read_safe": True,
        "parallel_write_safe": True,
    }
