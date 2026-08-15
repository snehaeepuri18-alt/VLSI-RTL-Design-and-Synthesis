# VLSI RTL Design and Synthesis Workshop

## Overview

This repository documents my learning and practical work during the VLSI RTL Design and Synthesis Workshop.

The workshop introduces the RTL design and verification flow, simulation, synthesis using Yosys, standard-cell libraries, and verification of synthesized designs.

---

## RTL Design

RTL (Register Transfer Level) is a design abstraction used to describe the behavior and data flow of a digital circuit.

RTL designs are generally written using a Hardware Description Language (HDL) such as Verilog.

---

## Testbench

A testbench is a Verilog environment used to apply inputs to a design and observe its outputs.

A basic testbench consists of:

- **Stimulus Generator** – generates the input signals.
- **Design** – the RTL module being tested.
- **Stimulus Observer** – observes the outputs of the design.

---

## Simulation

Simulation is used to verify the functional behavior of an RTL design before synthesis.

The design is simulated using a testbench, and the resulting signal transitions are analyzed to check whether the design behaves as expected.

---

## Icarus Verilog

Icarus Verilog (`iverilog`) is an open-source Verilog simulator used to simulate RTL designs and testbenches.

### Simulation Flow

    Design + Testbench
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

---

## VCD and GTKWave

### VCD

VCD (Value Change Dump) is a file format that records changes in signal values during simulation.

### GTKWave

GTKWave is a waveform viewer used to visualize and analyze signals stored in a VCD file.

---

## RTL Synthesis

Synthesis is the process of converting an RTL description into a gate-level representation or netlist.

The synthesis tool analyzes the RTL description and maps its functionality to available logic cells from a technology library.

### Basic Synthesis Flow

    RTL Design
         |
         v
      Synthesis
         |
         v
    Gate-Level Netlist

---

## Introduction to Yosys

Yosys is an open-source framework used for RTL synthesis.

In this workshop, Yosys is used to read Verilog RTL, perform synthesis operations, and generate a gate-level netlist.

### Basic Yosys Flow

           Design
              |
              | read_verilog
              v
            Yosys
              ^
              |
              | read_liberty
              |
          .lib File
              |
              v
         Netlist File
              ^
              |
         write_verilog

---

## Technology Library

A technology library contains information about the standard cells available for a particular semiconductor technology.

Liberty (`.lib`) files contain information about cells, including their logical functionality and timing characteristics.

The technology library is used during synthesis to map RTL functionality to appropriate standard cells.

---

## Synthesis Verification

After synthesis, the generated netlist can be simulated again using a testbench.

The purpose is to verify that the synthesized netlist produces the expected functional behavior.

### Synthesis Verification Flow

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
            |
            v
      Waveform Analysis

The synthesized design can therefore be checked against the original RTL behavior.

---

## Workshop Structure

### Day 1

RTL simulation, MUX design, Icarus Verilog, GTKWave, Yosys, and RTL synthesis.

### Day 2

Yosys visualization of multiple modules, D flip-flop designs, simulation, and GTKWave waveform analysis.

---

## Tools Used

- Verilog
- Icarus Verilog (`iverilog`)
- GTKWave
- Yosys
- SKY130 standard-cell library
- Ubuntu/Linux
