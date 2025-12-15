# ====== env settings ======
VENV			:= .venv
PYTHON 			:= $(VENV)/bin/python
PIP 			:= $(VENV)/bin/pip
REQUIREMENTS	:= $(VENV)/requirements.txt

# ==== Setup virtual environment ====
setup: $(VENV)/bin/activate ## Setup the python virtual environment
# ==== Project settings ====
PROJECT_NAME	:= traffic_light
SRCS_VHDL  		:= src/traffic_light.vhd
TB_VHDL    		:= tb/traffic_light_tb.vhd
FPGA       		?= xilinx        # choose: xilinx, ecp5, ice40


# Example FPGA parts and constraint files
PART_xilinx := xc7a35tcpg236-1

# Tool paths
BUILDD     := build
YOSYS      := yosys
GHDL       := ghdl
PYTHON     := python3
PYTHON_SCRIPT := scripts/json2rpt.py

# ==== FPGA-specific tool selection ====
synth_tool := synth_$(FPGA)
pnr_tool   := nextpnr-$(FPGA)
# ==== Default target ====
all: synth build

# ==== Help ====
help: ## Show this help message
	@echo "Usage: make [TARGET] [FPGA=xilinx|ecp5|ice40]"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

# ==== Build and simulation ====

bender: ## Run Bender to generate file lists
	@echo "Running Bender to generate file lists..."
	bender script flist > test.txt

flist_gen: bender ## Generate the ghdl file list
	@echo "Generating GHDL file list..."
	$(PYTHON) scripts/bender/flist_to_ghdl.py test.txt ghdl_flist.txt 

compile: flist_gen ## Compile the VHDL sources
	@set -eu; \
	while IFS= read -r cmd; do \
		echo "$$cmd"; \
		sh -c "$$cmd"; \
	done < ghdl_flist.txt

wave: sim
	gtkwave $(BUILDD)/wave.vcd &

## generare registers 
reg_gen: ## generare registers
	rggen --plugin rggen-vhdl -c regs/config.yml --output out regs/reg_map.yml

doc_gen: ## Generate documentation for the RTL design
	@echo "Moving to Dec scriptomg folder..."
	( cd scripts/doc_gen && make clean && make html )

project_setup: ## setup the project with the n defined at the top of this file, this should oly be run once st the start of the project
	@echo "Starting project setup..."
	@echo "cd'ing into th templater folder."
	@echo "Runing the templater script with the project name $(PROJECT_NAME)"
	( cd scripts/templater && python project_rename.py ../../src $(PROJECT_NAME) )
	@echo "Return to project base."

# ==== Clean ====
clean: ## Clean all outpt folders....
	rm -rf $(BUILDD) 
	rm -rf out
	(cd scripts/doc_gen && make clean )
