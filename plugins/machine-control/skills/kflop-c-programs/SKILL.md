---
name: kflop-c-programs
description: Use when writing, editing, or reviewing the real-time C programs that run on the KFlop DSP board itself (compiled via TCC67/KMotion.exe, not the C# UI layer). Trigger on mentions of KFlop C programs, TCC67, DSP program, KMotion.exe IDE, or motion/I-O logic that must run on the board rather than the host PC.
---

# KFlop real-time C programs

## What this is

The KFlop board (DSP + FPGA, 8 axes) runs compiled C programs for hard-real-time motion and I/O logic — this is separate from the C# UI layer, which runs on the host PC and talks to the board over the driver (see `kmotion-dotnet-bridge`). These C programs are written/compiled in `KMotion.exe` (the PC-side IDE), cross-compiled with `TCC67.exe`, and downloaded to the board as COFF objects — either manually through the IDE, or programmatically from the UI via `CKMotionDLL.CompileAndLoadCoff`.

## Real-time constraints

Code here executes on a DSP with a fixed real-time budget, not a general-purpose OS thread:
- No dynamic memory allocation patterns beyond what the existing program already uses — the DSP environment doesn't have a general-purpose heap in the way host-PC C code assumes.
- No blocking/long-running calls inside a control loop — anything that can stall breaks the real-time guarantee the motion control depends on.
- Timing-sensitive loops (servo update rates, I/O polling) should not be restructured without understanding the existing loop's timing budget — a change that looks like a harmless refactor on a PC can silently blow the DSP's cycle budget.

## Interaction with KMotionCNC

The DSP program can push status/commands back up to `KMotionCNC.exe` (the G-code CNC GUI) — see DynoMotion's KFLOP→KMotionCNC command reference if the custom UI needs to observe or replicate that channel rather than bypassing KMotionCNC entirely.

## Workflow

1. Edit the `.c` source in/alongside `KMotion.exe`.
2. Compile with `TCC67.exe` (either manually in the IDE, or via `CompileAndLoadCoff` from the C# bridge — see `kmotion-dotnet-bridge`).
3. Download/load the COFF to the board.
4. Test with the machine's motion range constrained or the tool retracted before running a full program, especially after any change to limits, homing, or loop timing.

## Safety note

Every edit under a KFlop C program directory in this repo triggers this plugin's `PreToolUse` advisory hook (see `hooks/hooks.json`), reminding to check the change against compile/timing constraints before it runs on hardware. Treat that reminder as real, not boilerplate — this is the one place in the stack where a bug moves physical steel.
