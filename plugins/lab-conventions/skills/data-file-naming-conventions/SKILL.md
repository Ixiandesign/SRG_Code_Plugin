---
name: data-file-naming-conventions
description: Use when naming or organizing files/folders for raw video, DIC/PIV outputs, machine logs, or any experiment-related data. Trigger on "how should I name this file", "folder structure for experiment data", or when creating new experiment output files.
---

# Data file naming conventions

## Why this exists

Raw video, machine logs, and analysis outputs for the same run need to be obviously linked to each other and to that run's metadata (see `experiment-metadata-schema`), even years later when nobody remembers the context. A consistent naming scheme makes that possible without opening every file to check.

## Canonical run identifier

Use a single run identifier, generated once per experiment run, and reuse it as a prefix across every file/folder that belongs to that run:

```
<YYYY-MM-DD>_<operator-initials>_<short-material-or-tool-tag>_<sequence>
```

Example: `2026-09-18_KTM_Ti6Al4V_001`

- `sequence` disambiguates multiple runs on the same day/material/operator combination — zero-padded (`001`, `002`, ...).
- Keep the `short-material-or-tool-tag` short and consistent across the lab (agree on a fixed vocabulary rather than letting it drift per student) — this belongs in the shared metadata schema, not reinvented per project.

## Directory structure per run

```
experiments/<run-id>/
├── metadata.json                 # per experiment-metadata-schema
├── raw_video/                    # unprocessed high-speed camera output
├── machine_log/                  # KMotion/KFlop status/position logs for the run
└── analysis/                     # DIC/PIV or other post-processed outputs, once produced
```

Keep raw data and derived/analysis outputs in clearly separate subfolders — never overwrite raw video or logs with a processed version; write outputs to `analysis/` instead.

## File naming within a run folder

Prefix individual files with the run ID even inside the run's own folder (`2026-09-18_KTM_Ti6Al4V_001_frame0001.tif` rather than just `frame0001.tif`) whenever a file is likely to ever be copied out of its folder — video frame sequences and analysis outputs especially tend to get pulled into a separate folder for processing, and an unprefixed filename loses its run association the moment that happens.

## Open item

The exact material/tool tag vocabulary hasn't been formalized yet — when this comes up in practice, agree on it as a lab and fold the fixed list into this skill rather than letting each student invent their own tags.
