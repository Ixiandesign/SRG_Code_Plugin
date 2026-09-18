---
name: gcode-interpreter-integration
description: Use when the custom UI needs to run G-code programs directly (without the KMotionCNC GUI) via GCodeInterpreter.dll's coordinated-motion/trajectory-planner class. Trigger on mentions of GCodeInterpreter.dll, running G-code from the custom UI, coordinated motion, or trajectory planning outside KMotionCNC.
---

# G-code interpreter integration

## What this is

DynoMotion ships `GCodeInterpreter.dll`, a standalone G-code interpreter / coordinated-motion / trajectory-planner component, separate from the full `KMotionCNC.exe` GUI application. It lets the custom UI execute G-code programs directly rather than shelling out to or reimplementing KMotionCNC.

## When to reach for this vs. KMotionCNC

- If the experiment workflow is: student sets parameters in the custom UI, UI generates or loads a G-code program, and the machine should just run it — use `GCodeInterpreter.dll` directly from the C# UI. This keeps the whole experiment loop inside one application instead of driving a second GUI program by remote control.
- If KMotionCNC's own G-code editor/jogging/DRO UI is what a student actually wants (e.g. manual setup, single-block stepping for a new toolpath), don't reimplement that — just launch/use KMotionCNC.
- Don't mix both approaches on the same axis set at the same time — two programs issuing motion commands to the same board is a coordination hazard, not just a code-style question.

## Integration pattern

`GCodeInterpreter.dll` sits alongside `KMotionDLL.dll`/`KMotion_dotNet.dll` in the deployment (see `kmotion-dotnet-bridge` for the full required-files list). Treat it as another .NET-consumable component from the same driver family rather than a separate subsystem to wrap independently — it still ultimately issues motion through the same board connection.

## Open item

The exact public class/method surface of `GCodeInterpreter.dll` (beyond "coordinated motion / trajectory planner") wasn't fully enumerated during initial research — when this skill is exercised for real, pull the current method signatures from DynoMotion's wiki/help pages or by inspecting the assembly (e.g. `ildasm`/decompiler) and fold the confirmed API into this skill file rather than guessing at method names.
