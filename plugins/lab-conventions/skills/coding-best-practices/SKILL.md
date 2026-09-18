---
name: coding-best-practices
description: Use as general guidance for any code written across Schoop Research Group projects — commit hygiene, code review expectations, language style norms (C#, MATLAB, Python), and heightened review posture for anything touching real-time motion control. Trigger on general "how should I structure/commit/review this" questions not covered by a more specific skill.
---

# Lab coding best practices

## Who this is for

Grad students in a research lab, not a professional engineering team — most contributors are not full-time software developers, code often has a single author/user, and projects get picked up by a new student every few years. Optimize guidance for **that** context: clarity and traceability over process overhead.

## Commit hygiene

- Commit messages should explain *why*, not just *what* — the next person maintaining this code (often a new student, possibly you in a year) won't have the context you have now.
- Commit working states, not everything-at-once dumps — a change to the experiment-config UI and an unrelated fix to a DIC script belong in separate commits even if they happened in the same sitting.
- Don't commit large binary data (raw video, big datasets) into git — point to where it actually lives (shared drive, lab storage) instead. Git history bloat from accidental binary commits is expensive to undo later.

## Code review expectations

- Any change that can move the physical machine (see `kmotion-integration-agent` in the `machine-control` plugin) gets a second pair of eyes before running on hardware, even informally — a quick "does this look right to you" to another student counts.
- For analysis code (MATLAB/Python), review for correctness of the actual computation over style — a strain-field calculation that's subtly wrong is a much bigger problem than inconsistent indentation.

## Language-specific norms

- **C# (custom UI)**: standard .NET naming conventions (PascalCase for public members, camelCase for locals/private fields). Keep motion-commanding code paths (see `kmotion-dotnet-bridge`) clearly separated from read-only/status code paths — this matters more than any stylistic convention.
- **MATLAB (analysis codes)**: keep scripts runnable end-to-end from a clean workspace — avoid hidden dependencies on variables left over from a previous manual run. Prefer functions over script-only logic once a piece of analysis is reused more than once.
- **Python (where used)**: follow standard PEP 8 conventions; keep environment/dependency requirements documented (a `requirements.txt` or equivalent) since lab machines vary in what's already installed.

## Safety-critical code review posture

Real-time KFlop C programs and any motion-commanding call are the one place in this stack where a bug has physical consequences beyond wasted time. Apply extra scrutiny there specifically — see the `kflop-c-programs` and `kmotion-dotnet-bridge` skills in the `machine-control` plugin for what that means concretely. Don't apply the same heavyweight review process to a DIC post-processing script; match the review effort to the actual risk.
