# Module 4: Gate-Level Simulation, Blocking vs Non-Blocking Assignments and Synthesis-Simulation Mismatch

## 1. Overview

This module focuses on Gate-Level Simulation (GLS), blocking and non-blocking assignments, and synthesis-simulation mismatch.

The objective is to understand how RTL code behaves during simulation, how synthesis converts RTL into a gate-level netlist, and how the synthesized design can be verified using Gate-Level Simulation.

The practical work includes two synthesis-simulation mismatch cases and one synthesis-simulation matching case. Yosys was used for synthesis, Icarus Verilog was used for simulation, and GTKWave was used for waveform analysis.

---

## 2. Gate-Level Simulation (GLS)

Gate-Level Simulation is performed after the RTL design has been synthesized.

During synthesis, the RTL design is converted into a gate-level netlist consisting of logic gates and other hardware elements.

The generated netlist can then be simulated using the same or an appropriate testbench to verify that the synthesized design behaves as expected.

### GLS Flow

```text
RTL Design
    |
    v
RTL Simulation
    |
    v
Synthesis
    |
    v
Gate-Level Netlist
    |
    v
Gate-Level Simulation
    |
    v
Waveform Analysis
```

---

## 3. Why Gate-Level Simulation is Performed

Gate-Level Simulation helps verify the behavior of the synthesized design.

The main objectives of GLS are:

- Verify that the synthesized netlist functions correctly.
- Compare RTL simulation results with gate-level simulation results.
- Detect synthesis-simulation mismatches.
- Verify whether the intended hardware behavior is preserved after synthesis.
- Perform functional verification of the synthesized design.
- Analyze timing-related behavior when timing information is available.

---

## 4. Functional and Timing Verification

### Functional Verification

Functional verification checks whether the synthesized gate-level netlist produces the expected output for the given input conditions.

The output from Gate-Level Simulation can be compared with the output from RTL simulation.

If both produce the expected behavior, the design is functionally consistent.

### Timing Verification

Timing verification checks whether the synthesized design behaves correctly when propagation delays and timing information are considered.

In a complete ASIC design flow, timing information can be added to the gate-level netlist for more detailed timing analysis.

For this module, the main focus is on functional Gate-Level Simulation and comparing RTL behavior with synthesized gate-level behavior.

---

## 5. Synthesis-Simulation Mismatch

A synthesis-simulation mismatch occurs when the behavior observed during RTL simulation is different from the behavior of the synthesized gate-level design.

This can happen when the RTL code does not accurately describe the intended hardware.

Some common causes of synthesis-simulation mismatch include:

- Missing signals in the sensitivity list.
- Incomplete conditional assignments.
- Incomplete `case` statements.
- Unintended latch inference.
- Incorrect use of blocking and non-blocking assignments.
- Simulation-specific coding behavior that does not represent actual hardware.

### Missing Sensitivity List

In Verilog, an `always` block must include all signals that affect the logic in its sensitivity list.

For example:

```verilog
always @(a or b)
```

If a signal affecting the logic is missing from the sensitivity list, simulation may not update correctly when that signal changes.

This can result in a synthesis-simulation mismatch.

Using:

```verilog
always @(*)
```

automatically includes all signals used in the combinational logic and helps avoid missing sensitivity-list issues.

---

## 6. Blocking and Non-Blocking Assignments

### Blocking Assignment

Blocking assignment uses `=` and is generally used for combinational logic.

```verilog
always @(*)
begin
    a = b;
    c = a;
end
```

In a blocking assignment, statements execute sequentially.

The value of `a` is updated immediately before the next statement is executed.

Therefore, `c` receives the updated value of `a`.

### Non-Blocking Assignment

Non-blocking assignment uses `<=` and is generally used for sequential logic.

```verilog
always @(posedge clk)
begin
    a <= b;
    c <= a;
end
```

In a non-blocking assignment, the right-hand-side expressions are evaluated first, and the updates are scheduled to occur together.

Therefore, `c` receives the previous value of `a`, while `a` receives the value of `b`.

Using the appropriate assignment type is important for correctly modeling the intended hardware.

---

## 7. Practical Gate-Level Simulation

Three cases were studied during the practical work:

- Two synthesis-simulation mismatch cases.
- One synthesis-simulation matching case.

For each design, the following steps were performed:

1. Write the RTL design.
2. Perform RTL simulation.
3. Analyze the RTL waveform.
4. Synthesize the design using Yosys.
5. Generate the synthesized gate-level netlist.
6. Perform Gate-Level Simulation.
7. Compare the RTL and gate-level simulation results.
8. Analyze the results using GTKWave.

The Yosys synthesis results and GTKWave waveforms were examined for each case.

---

## 8. Synthesis-Simulation Mismatch – Case 1

The first example demonstrated a mismatch between RTL simulation and Gate-Level Simulation.

The RTL behavior did not correctly match the behavior inferred after synthesis.

### Yosys Result

![Mismatch Case 1 – Yosys](bad_mux_show.png)

### GTKWave Waveform

![Mismatch Case 1 – GTKWave](gls_bad_mux.png)

### Observation

The RTL simulation and synthesized gate-level behavior showed different results for certain input conditions.

This demonstrates how improper RTL coding can lead to a difference between simulation behavior and synthesized hardware.

---

## 9. Synthesis-Simulation Mismatch – Case 2

The second example demonstrated another synthesis-simulation mismatch.

This case focused on the effect of RTL coding style and assignment behavior.

### Yosys Result

![Mismatch Case 2 – Yosys](blocking_show.png)

### GTKWave Waveform

![Mismatch Case 2 – GTKWave](gls_blocking.png)

### Observation

The simulation behavior and synthesized hardware behavior were not consistent.

This demonstrates the importance of correctly modeling combinational and sequential logic using appropriate Verilog coding practices.

---

## 10. Synthesis-Simulation Match

The third example demonstrated a matching case where the RTL and synthesized gate-level behavior were consistent.

The RTL correctly described the intended hardware, and the synthesized netlist produced the expected output.

### Yosys Result

![Matching Case – Yosys](ternary_mux_show.png)

### GTKWave Waveform

![Matching Case – GTKWave](gls_ternary_mux.png)

### Observation

The RTL simulation and Gate-Level Simulation produced consistent results.

This confirms that the RTL code was correctly synthesized into the intended hardware.

---

## 11. Overall RTL-to-GLS Flow

```text
RTL Design
     |
     v
RTL Simulation
     |
     v
Synthesis
     |
     v
Gate-Level Netlist
     |
     v
Gate-Level Simulation
     |
     v
GTKWave Analysis
```

The RTL design is first simulated to verify its functionality.

The design is then synthesized using Yosys to generate a gate-level netlist.

The generated netlist is simulated again using Gate-Level Simulation.

Finally, the RTL and gate-level simulation results are compared using GTKWave.

---

## 12. Key Learnings

- Understood the concept of Gate-Level Simulation.
- Learned why GLS is performed after synthesis.
- Understood the difference between RTL simulation and Gate-Level Simulation.
- Understood functional and timing verification.
- Learned about synthesis-simulation mismatch.
- Understood how improper RTL coding can result in unexpected synthesized hardware.
- Understood the effect of a missing sensitivity list.
- Learned the difference between blocking (`=`) and non-blocking (`<=`) assignments.
- Understood the importance of using blocking assignments for combinational logic.
- Understood the importance of using non-blocking assignments for sequential logic.
- Compared two synthesis-simulation mismatch cases.
- Verified one synthesis-simulation matching case.
- Verified synthesized designs using Yosys and GTKWave.

---

## Conclusion

Module 4 provided practical understanding of Gate-Level Simulation, blocking and non-blocking assignments, and synthesis-simulation mismatch.

The module covered the process of converting RTL designs into synthesized gate-level netlists and verifying the synthesized design using Gate-Level Simulation.

The importance of proper Verilog coding practices was also studied, including the correct use of sensitivity lists, blocking assignments, and non-blocking assignments.

Two synthesis-simulation mismatch cases and one matching case were analyzed using Yosys synthesis results and GTKWave waveforms.

This module demonstrates that successful RTL simulation alone does not always guarantee that the synthesized hardware will behave exactly as expected. Proper RTL coding and post-synthesis verification are important steps in the digital design flow.
