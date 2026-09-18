---
name: kmotion-dotnet-bridge
description: Use when writing or reviewing C# code that connects the lab's custom WPF/WinForms UI to the KFlop board via KMotion_dotNet.dll / KMotionDLL.dll — calling motion commands, reading axis/status state, loading DSP programs, or handling the driver's client-server/threading model. Trigger on mentions of KMotion_dotNet, KMotionDLL, CKMotionDLL, KFlop from C#, or "how do I control the machine from the UI".
---

# KMotion .NET bridge

## What this is

The custom orthogonal-cutting-machine UI is a C# (WPF/WinForms) application. It does not talk to the KFlop board directly — it goes through DynoMotion's native driver, `KMotionDLL.dll`, wrapped for .NET consumption by `KMotion_dotNet.dll` + `KMotion_dotNet_Interop.dll`. This is the officially supported path for C#/VB.NET (also used by LabVIEW). There is no ActiveX/COM interface — it's .NET interop, so reference the assemblies directly in the C# project rather than reaching for COM interop patterns.

## Required files alongside the executable

Deployment needs these copied next to the app binary (not just referenced at compile time):
`KMotionDLL.dll`, `KMotion_dotNet.dll`, `KMotion_dotNet_Interop.dll`, `GCodeInterpreter.dll`, `KMotionServer.exe`, `TCC67.exe`.

## Core API surface (`CKMotionDLL`)

```csharp
var km = new CKMotionDLL(0);              // board 0 — driver is client-server, multi-board/multi-thread aware
km.WriteLine("Move(1000)");               // fire-and-forget command to the board
km.WriteLineReadLine("Position(0)", out string resp);  // send + block for single-line response
km.WaitToken(timeoutMs);                  // acquire the board lock across threads before a command sequence
km.LoadCoff(path);                        // deploy a precompiled KFlop C program
km.CompileAndLoadCoff(sourcePath);        // compile (via TCC67) and deploy in one step
```

`WaitToken` matters because the driver is explicitly multi-thread/multi-process aware — if the UI has more than one thread issuing commands (e.g. a status-polling timer plus a user-triggered move), take the token before a command sequence that must not interleave with another caller.

## Read-only vs. motion-commanding calls

Split UI code paths clearly: status/read calls (position, I/O bit state, program-running flag) are safe to poll from a background timer for live display. Anything that moves the machine (`Move`, jog, homing, or a G-code dispatch) should go through a single, explicit, user-triggered code path — don't let a status-polling loop accidentally re-issue a motion command on reconnect/retry logic.

## Standalone G-code execution

For running G-code without the KMotionCNC GUI, use `GCodeInterpreter.dll`'s coordinated-motion/interpreter class rather than re-implementing G-code parsing in the custom UI. See the `gcode-interpreter-integration` skill for detail.

## No official Python wrapper

If a script or tool needs to reach the board from Python rather than the C# UI, there's no first-party wrapper. The two community patterns are `pythonnet` (load `KMotion_dotNet.dll` via `clr.AddReference`) or raw `ctypes` against `KMotionDLL.dll`'s native exports. Prefer `pythonnet` — it reuses the same `CKMotionDLL` surface documented above instead of re-deriving the native calling convention.

## Reference implementations

- github.com/mhaberler/KMotion432 — Windows C#/.NET interop examples, including a `KM_Controller.cs` wrapper worth reading before writing a new one from scratch.
- dynomotion.com/wiki "PC Example Applications" — includes a minimal C# starter ("SimpleFormsCS").
- github.com/parhansson/KMotionX — Linux port; useful for understanding driver internals even though this lab targets Windows.

## Safety note

Any code path that calls a motion-commanding method (not just status/read) should be treated with the extra scrutiny described in the `kmotion-integration-agent` subagent — flag it rather than writing it silently.
