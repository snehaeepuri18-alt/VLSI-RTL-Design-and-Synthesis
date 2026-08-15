# Day 1 – RTL Design and Synthesis

## Overview

Day 1 of the VLSI RTL Design and Synthesis Workshop focused on understanding the RTL-to-synthesis flow through a practical Multiplexer (MUX) design.

The design was written in Verilog, simulated using Icarus Verilog, and synthesized using Yosys.

---

## 1. MUX Design

A Multiplexer (MUX) is a combinational digital circuit that selects one of multiple input signals and forwards the selected input to the output based on the select signal.

For the design implemented during the workshop, a 2:1 MUX was used.

### 2:1 MUX

A 2:1 MUX has:

- Two data inputs: `i0` and `i1`
- One select input: `sel`
- One output: `y`

The functional relationship is:

    sel = 0  →  y = i0
    sel = 1  →  y = i1

### Truth Table

| sel | i0 | i1 | y |
|-----|----|----|---|
| 0   | 0  | 0  | 0 |
| 0   | 0  | 1  | 0 |
| 0   | 1  | 0  | 1 |
| 0   | 1  | 1  | 1 |
| 1   | 0  | 0  | 0 |
| 1   | 0  | 1  | 1 |
| 1   | 1  | 0  | 0 |
| 1   | 1  | 1  | 1 |

---

## 2. Verilog RTL Design

The MUX was described using Verilog RTL.

The RTL source file used in the experiment is:

`good_mux.v`

The RTL describes the intended functional behavior of the MUX.

---

## 3. Testbench

A testbench was created to verify the functionality of the MUX.

The testbench file used was:

`tb_good_mux.v`

The testbench applies different combinations of input and select signals and observes the output of the MUX.

---

## 4. RTL Simulation

The RTL design and testbench were simulated using Icarus Verilog.

### Simulation Flow

    RTL Design + Testbench
             |
             v
       Icarus Verilog
             |
             v
           VCD File
             |
             v
          GTKWave
             |
             v
      Waveform Analysis

The simulation results were observed using GTKWave to verify the functional behavior of the MUX.

---

## 5. Yosys Synthesis

Yosys was introduced as an open-source RTL synthesis tool.

The RTL design was processed using Yosys to perform synthesis and generate a gate-level representation.

The basic synthesis process is:

    Verilog RTL
         |
         v
       Yosys
         |
         v
      Synthesis
         |
         v
    Gate-Level Netlist

---

## 6. Netlist Generation

The synthesized netlist generated from the MUX RTL design is:

`good_mux_netlist.v`

The netlist represents the synthesized implementation of the RTL design.

---

## 7. RTL and Netlist Verification

The synthesized netlist can be verified using the testbench and simulator.

The simulation flow is:

    Netlist + Testbench
             |
             v
       Icarus Verilog
             |
             v
           VCD File
             |
             v
          GTKWave

The purpose of this verification is to confirm that the synthesized implementation preserves the intended functionality of the original RTL design.

---

## 8. Files in Day 1

| File | Description |
|------|-------------|
| `good_mux.v` | Verilog RTL design of the MUX |
| `tb_good_mux.v` | Testbench used for MUX verification |
| `good_mux_netlist.v` | Synthesized gate-level netlist |

---

## 9. Key Learnings

- Understood the basic RTL design flow.
- Implemented a 2:1 MUX using Verilog.
- Created a testbench for functional verification.
- Performed RTL simulation using Icarus Verilog.
- Generated and analyzed simulation waveforms using GTKWave.
- Learned the basics of RTL synthesis using Yosys.
- Generated a synthesized netlist from the RTL design.
- Understood the relationship between RTL, testbench, simulation, synthesis, and netlist.

---

## Conclusion

Day 1 provided practical exposure to the basic RTL design and synthesis flow using a 2:1 MUX.

The complete flow covered RTL design, testbench creation, simulation, waveform analysis, synthesis using Yosys, and netlist generation.
