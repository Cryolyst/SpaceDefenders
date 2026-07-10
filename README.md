# FPGA Arcade-Style Game

![Demo](SpaceDefenders.gif)

## Overview
This repository contains the RTL design and verification files for a custom arcade-style game implemented on an FPGA. The game logic is written entirely in SystemVerilog and outputs real-time visuals to a 16x16 LED matrix display. 

This project was developed to demonstrate proficiency in digital logic design, state machine implementation, and hardware-level timing constraints.

## Tech Stack & Tools
* **Hardware Description Language:** SystemVerilog
* **Synthesis & Routing:** Intel Quartus
* **Hardware:** DE1-SoC
* **Peripherals:** 16x16 Matrix Display

## System Architecture
The design is broken down into several modular components to separate the game logic from the hardware interface:

* `Space_Defender.sv`: The top-level module that wires the internal logic to the physical I/O pins.
* `DebrisLogic.sv`: Contains the core Finite State Machine (FSM) governing gameplay, scoring, and win/loss states.
* `MatrixRender.sv`: Handles the timing and multiplexing required to drive the 16x16 matrix display.
* `UserInput.sv`: Synchronizes asynchronous button presses to the system clock and includes debouncing logic.

### State Machine Diagram
*(Insert a clean photo or digital drawing of your FSM here. Recruiters love seeing the logic flow!)*
![FSM Diagram](TopLevelDiagram.pdf)

## Simulation & Verification
Prior to synthesis, all modules were verified using testbenches to ensure proper timing and state transitions.

* **Simulation Tool:** [ModelSim]
* To run the main testbench:
  1. Open the project in your simulation environment.
  2. Compile `Space_Defender.sv`.
  3. Run the simulation to view the waveform outputs verifying the FSM transitions.

## Hardware Implementation
1. Open the `Space_Defender.qsf` file in Intel Quartus.
2. Ensure the pin assignments match your specific board (refer to `Space_Defender.qsf`).
3. Compile the design.
4. Program the FPGA using the generated `Space_Defender.sof` file.

## Key Learnings & Challenges
* **Timing Constraints:** Navigated strict clock requirements to ensure the 16x16 matrix updated without flickering or visual artifacts.
* **FSM Complexity:** Designed a robust state machine that cleanly handled edge cases during rapid user inputs.
* **Modular Design:** Learned the importance of separating interface logic from core gameplay mechanics to make debugging easier.
