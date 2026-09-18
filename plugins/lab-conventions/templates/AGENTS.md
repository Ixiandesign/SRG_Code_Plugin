# AGENTS.md — Schoop Research Group project conventions

> Copy this file into a new project repo's root as `AGENTS.md`, then fill in the sections below.
> This file is read by AGENTS.md-aware tools (Cursor, Windsurf, Codex, Gemini CLI, Zed, and others).
> Claude Code reads `CLAUDE.md` — that file should contain only `@AGENTS.md` and nothing else.

## What this project is

<!-- One or two sentences: what does this repo do? Which lab systems does it touch —
     the custom machine-control UI, DIC/PIV analysis, both, or something else? -->

## Machine safety

- Any code that can move the physical 3-axis orthogonal cutting machine (motion commands via
  `KMotion_dotNet.dll`/`KMotionDLL.dll`, or real-time KFlop C programs) needs a second pair of eyes
  before running on hardware — see the `machine-control` plugin's `kmotion-integration-agent` and
  `kflop-c-programs` skill.
- Never change axis soft/hard limits, homing routines, or feed/speed defaults without stating
  explicitly what changed and why, and confirming with another lab member before running it.
- Test on the machine with reduced range / tool retracted, or on a simulator if available, before
  running a new or changed motion program at full parameters.

## Experiment data conventions

- Follow the `experiment-metadata-schema` and `data-file-naming-conventions` skills (`lab-conventions`
  plugin) for every recorded run — required fields, run ID format, and directory layout.
- Raw data (video, machine logs) and derived/analysis outputs go in separate subfolders; never
  overwrite raw data with a processed version.

## Environment notes

<!-- Fill in for this specific project: -->
- MATLAB version required: <!-- e.g. R2021b+ for MATLAB language server support -->
- .NET version: <!-- e.g. .NET Framework 4.8 / .NET 8, whichever the custom UI targets -->
- Python environment: <!-- if used, note how it's managed (venv, conda, requirements.txt path) -->
- Required hardware/software on the dev machine: <!-- KMotion.exe, KMotionCNC.exe, PFV4, etc. -->

## Coding conventions

See the `lab-conventions` plugin's `coding-best-practices` skill for lab-wide commit/review/style
norms. Project-specific deviations, if any, go here:

<!-- project-specific notes -->
