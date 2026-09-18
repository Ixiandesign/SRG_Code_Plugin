---
name: orthogonal-cutting-experiment-config
description: Use when designing the custom UI's experiment-configuration screen or data model — mapping cutting parameters (feed rate, depth of cut, tool geometry, workpiece material, spindle/cutting speed) to actual axis motion setup and G-code/KFlop program generation. Trigger on "experiment config", "run parameters", "cutting parameters UI", or "how should the UI represent an experiment".
---

# Orthogonal cutting experiment configuration

## What this is

The custom UI's core job is letting a student configure and run an orthogonal-cutting experiment without hand-editing G-code or KFlop C programs each time. This skill is about the data model and UI/config layer that sits above the motion-control calls covered in `kmotion-dotnet-bridge` and `gcode-interpreter-integration` — it's the "what does an experiment run consist of" layer.

## Typical parameters to model

- **Cutting parameters**: cutting speed, feed rate (or feed per revolution/stroke depending on how this machine's kinematics are set up), depth of cut, cutting distance/stroke length.
- **Tool geometry**: rake angle, clearance angle, edge radius, tool material/coating — these usually don't drive motion directly but need to be captured for the experiment record (see `experiment-metadata-schema` in `lab-conventions`).
- **Workpiece**: material, dimensions, any pre-machining state.
- **Axis mapping**: how the above parameters translate to this specific 3-axis machine's motion program — feed rate and depth of cut map to specific axis moves, and that mapping is machine-specific, so document it explicitly in code rather than leaving it implicit in a G-code template.

## Design guidance

- Keep the experiment-config data model separate from the motion-execution code path — the UI should be able to validate/save/reload a configuration without touching the board, and only hand off to `kmotion-dotnet-bridge`/`gcode-interpreter-integration` once a run is actually started.
- Every saved experiment configuration should carry enough information to regenerate the exact G-code/KFlop program that ran, plus the metadata fields required by `experiment-metadata-schema` — configuration and metadata should not drift into two separate, inconsistent records of the same run.
- Validate parameters against the machine's actual travel/feed/limit envelope before generating motion, not just against generic sanity bounds — a value that's numerically reasonable for orthogonal cutting in general can still exceed this specific machine's soft limits.

## Open item

The exact kinematic mapping from (feed rate, depth of cut, tool geometry) to this machine's specific axis moves depends on the physical machine setup and hasn't been documented yet — fill this in once the mapping is finalized, rather than guessing at axis conventions here.
