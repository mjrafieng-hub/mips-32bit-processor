<div align="center">

# ⚡ 32-Bit MIPS Processor (Single-Cycle)

[![Language](https://img.shields.io/badge/Language-Verilog_HDL-blue.svg)](https://en.wikipedia.org/wiki/Verilog)
[![Architecture](https://img.shields.io/badge/Architecture-MIPS32_Single--Cycle-orange.svg)]()
[![Target](https://img.shields.io/badge/Target-Xilinx_Spartan--6-red.svg)]()
[![Status](https://img.shields.io/badge/Status-Work_In_Progress-yellow.svg)]()

A clean, modular **32-bit Single-Cycle MIPS Processor** implementation in **Verilog HDL**, designed for digital logic synthesis, simulation, and FPGA prototyping.

</div>

---

## 📌 Overview

This repository contains the Register-Transfer Level (RTL) design and verification environment for a classic **32-bit MIPS Single-Cycle Architecture**. Each instruction (R-Type, I-Type, and J-Type) is fetched, decoded, executed, and written back within a single clock cycle.

> **🚧 Project Status:** This project is currently under active development (**Baseline RTL Completed**). Ongoing updates include ISA expansion, comprehensive self-checking testbenches, and timing optimization for Xilinx Spartan-6 FPGA synthesis.

---

## 🗂️ Repository Structure

The project follows an industry-standard directory layout for RTL design and verification:

```text
mips-32bit-processor/
├── doc/                        # Architecture specifications & datapath diagrams
├── rtl/                        # Synthesizable Verilog RTL source files
│   ├── Top_module.v            # Top-level processor integration (Datapath + Control)
│   ├── control_unit.v          # Main decoder and ALU control unit
│   ├── alu.v                   # 32-bit Arithmetic Logic Unit
│   ├── register_file.v         # 32x32-bit general-purpose register file
│   ├── Instruction_Memory.v    # ROM for instruction fetch (IMEM)
│   └── datamemory.v            # RAM for load/store operations (DMEM)
├── tb/                         # Verification testbenches
│   └── test_singel_cycle.v     # Top-level testbench for single-cycle execution
├── sim/                        # Simulation scripts, waveforms, and memory dumps
├── sw/                         # MIPS assembly test programs (.asm, .hex, .coe)
└── build/                      # Synthesis & FPGA implementation artifacts (ISE/Vivado)
```

---

## 🧩 RTL Module Status

| Module | File Name | Description | Status |
| :--- | :--- | :--- | :---: |
| **Top Level** | `rtl/Top_module.v` | Complete Datapath & Control Unit integration | ✅ Initial RTL |
| **Control Unit** | `rtl/control_unit.v` | Opcode & Funct decoder generating control signals | ✅ Initial RTL |
| **ALU** | `rtl/alu.v` | 32-bit arithmetic & logic operations + Zero flag | ✅ Initial RTL |
| **Register File** | `rtl/register_file.v` | 32 registers (`$0` hardwired to 0), dual-read / single-write | ✅ Initial RTL |
| **Instruction Memory** | `rtl/Instruction_Memory.v` | Word-aligned instruction memory | ✅ Initial RTL |
| **Data Memory** | `rtl/datamemory.v` | Synchronous write / asynchronous read data RAM | ✅ Initial RTL |
| **Testbench** | `tb/test_singel_cycle.v` | Functional verification of the single-cycle datapath | 🔄 Expanding |

---

## 🚀 Quick Start (Simulation)

### Using ModelSim / QuestaSim
1. Clone the repository:
   ```bash
   git clone https://github.com/mjrafieng-hub/mips-32bit-processor.git
   cd mips-32bit-processor
   ```
2. Compile the RTL and Testbench files:
   ```tcl
   vlib work
   vlog rtl/*.v tb/test_singel_cycle.v
   ```
3. Run the simulation:
   ```tcl
   vsim -voptargs=+acc work.test_singel_cycle
   add wave -r /*
   run -all
   ```

### Using Xilinx ISE (Synthesis)
1. Create a new project in **Xilinx ISE Design Suite** targeting your FPGA (e.g., **Spartan-6**).
2. Add all Verilog files from the `rtl/` directory as Design Sources (`Top_module.v` as Top-Level).
3. Add `tb/test_singel_cycle.v` as a Simulation-only source for ISim verification.

---

## 🗺️ Development Roadmap

- [x] **Phase 0:** Repository structure setup & Git workflow initialization
- [x] **Phase 1:** Baseline Single-Cycle RTL implementation (`rtl/` & `tb/`)
- [ ] **Phase 2:** RTL code review, naming standardization, and ISA verification
- [ ] **Phase 3:** Adding assembly test programs (`sw/`) and waveform documentation (`doc/`)
- [ ] **Phase 4:** Synthesis & timing analysis on Xilinx Spartan-6 FPGA
- [ ] **Phase 5:** Future expansion to Multi-Cycle / 5-Stage Pipelined MIPS architecture

---

## 👤 Author

**Mohammad Javad Rafieian**  
*Electrical & Electronics Engineering — Shahid Bahonar University of Kerman*  
🔗 [GitHub Profile](https://github.com/mjrafieng-hub)
