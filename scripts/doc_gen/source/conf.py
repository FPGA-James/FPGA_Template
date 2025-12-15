# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

import os
import sys

project = 'axi_test'
copyright = '2025, James Fleeting'
author = 'James Fleeting'
release = '1'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
#sys.path.append(os.path.abspath("_ext"))

sys.path.insert(0, os.path.abspath("../_ext"))
extensions = [
    "sphinxvhdl.vhdl",
    "sphinx.ext.autodoc",
    "sphinxcontrib.wavedrom",
]

vhdl_autodoc_source_path = [ os.path.abspath('../../../src')]

templates_path = ['_templates']
exclude_patterns = []

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'alabaster'
html_static_path = ['_static']

# Enable autodoc if needed (entities, architectures, packages, signals, types)
#
# wavedrom_output_format = "svg"