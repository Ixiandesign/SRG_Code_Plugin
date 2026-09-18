---
name: camera-trigger-sync
description: Use when wiring the custom UI or KFlop program to synchronize the Photron high-speed camera (PFV4) with a cutting run — hardware TTL trigger wiring, or (if SDK access is confirmed) programmatic PFV4 control via PDCLIB. Trigger on mentions of PFV4, Photron, high-speed camera trigger, TTL trigger, PDCLIB, or "sync the camera with the machine".
---

# Camera trigger sync (PFV4)

## Default path: hardware TTL trigger (no SDK needed)

The camera's `TRIG TTL IN` / `GENERAL IN` port accepts a TTL pulse to start/stop recording (isolated, configurable polarity on Photron high-speed cameras; Orion-series cameras expose multiple programmable BNC in/out lines for this). The natural pattern for this lab's setup:

1. The KFlop real-time C program (see `kflop-c-programs`) toggles a digital output pin at the toolpath event that should start recording (e.g. tool engagement).
2. That output wires directly into the camera's `TRIG TTL IN`.
3. Recording starts hardware-synchronized to the actual motion event, with zero dependency on the PFV4 SDK.

This is the default integration path for this plugin — it requires no vendor SDK access and should be the first thing implemented. Document the specific KFlop digital-output pin and camera trigger-port wiring once the physical setup is finalized, so future changes don't have to re-derive it from the hardware.

## Optional path: PDCLIB (only if SDK access is confirmed)

Photron gates programmatic PFV4 control behind PDCLIB (a C-based SDK: `PDCLIB.dll`/`.lib` + headers, e.g. `PDC_EraseCachedCorrectionData`, `PDC_GRAWFileLoad`), versioned to match the installed PFV4 build. Access requires submitting Photron's "SDK Access Request Form" — there is no public download. Official wrappers exist for MATLAB and LabVIEW in addition to the native C API; no COM/.NET surface is confirmed, so a C# integration would likely go through P/Invoke against `PDCLIB.dll` (unverified — confirm against the actual SDK docs once access is granted).

Only reach for this path if the experiment needs the custom UI to programmatically command recording start/stop or pull frame data back into the app — the hardware TTL path above already covers "start recording when the cut starts" without it.

**Status in this lab**: SDK access is not yet confirmed either way. Treat this section as a stub — do not assume PDCLIB is available. If a task requires it, confirm access first rather than writing P/Invoke code against an unverified API surface.

## Combining with force/sensor data logging

If the experiment also logs force or other sensor data on a DAQ, use the same trigger pulse (or a shared timestamp/clock) to align the camera recording with that data rather than maintaining two independent, loosely-synced timelines.
