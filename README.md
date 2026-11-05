
# FIFO RTL Verification using SystemVerilog

## Project Overview
A synchronous FIFO (First-In First-Out) design implemented in SystemVerilog and verified using a self-checking testbench.

## Design Specifications
- Data Width: 8 bits
- FIFO Depth: 8 entries
- Synchronous read/write operations
- Active-low asynchronous reset
- Full and Empty status flags
- Almost Full and Almost Empty flags
- Overflow and Underflow detection
- Write acknowledgement

## Verification Methodology
- SystemVerilog interface-based testbench
- Reference queue model
- Self-checking transaction task
- Directed and random test scenarios
- SystemVerilog assertions
- Waveform analysis using GTKWave

## Test Scenarios
1. Reset operation
2. Single write
3. Single read
4. Multiple writes
5. Multiple reads
6. FIFO full condition
7. Overflow detection
8. Underflow detection
9. Pointer wraparound
10. Simultaneous read and write
11. Almost full condition
12. Almost empty condition
13. Different data patterns
14. Random transactions
15. Reset during operation
16. Simultaneous read/write when full
17. Simultaneous read/write when empty

## Tools Used
- SystemVerilog
- Verilator 5.032
- GTKWave 3.3.126
- VS Code
- WSL Ubuntu

## How to Run

### Compile
```bash
verilator --binary --timing --trace -Wall -Wno-fatal fifo_if.sv fifo_assertions.sv FIFO.sv fifo_testbench.sv --top-module fifo_testbench
```

### Simulate
```bash
./obj_dir/Vfifo_testbench
```

### View Waveforms
```bash
gtkwave fifo_waveform.vcd
```

## Project Objective
To understand RTL verification concepts, FIFO functionality, reference modeling, assertions, and simulation-based verification using SystemVerilog.
