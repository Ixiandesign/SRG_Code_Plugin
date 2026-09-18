---
name: experiment-metadata-schema
description: Use when creating, saving, or reviewing files that record an experiment run — defines the required metadata fields so runs stay comparable and traceable across the lab. Trigger on "experiment metadata", "what fields does a run need", "saving experiment data", or when a new file is being written under an experiments/ or data/ directory.
---

# Experiment metadata schema

## Why this exists

Different students run experiments on the same machine over years. Without a shared metadata convention, comparing or reusing someone else's run data means guessing at what parameters they used. Every recorded experiment should carry enough metadata to be understood and reproduced without asking the person who ran it.

## Required fields

Every experiment record (however it's stored — a config file, a data file header, a companion `.json`/`.yaml` sidecar) should include:

- **Run identifier**: unique ID or timestamp-based name (see `data-file-naming-conventions` for the canonical format).
- **Date and operator**: who ran it, when.
- **Material**: workpiece material and any relevant condition (heat treatment, prior machining state).
- **Tool**: tool geometry (rake angle, clearance angle, edge radius), material/coating, and tool ID if tools are tracked individually.
- **Cutting parameters**: cutting speed, feed rate, depth of cut, cutting distance — whatever the `orthogonal-cutting-experiment-config` skill's data model captures for that run.
- **Camera settings**: frame rate, resolution, exposure, lens/magnification, and whether the run has synchronized video at all — a lot of runs won't have video, and that should be recorded explicitly rather than left ambiguous.
- **Notes/anomalies**: anything that deviated from a normal run (tool wear observed, aborted mid-run, sensor dropout) — free text is fine here, but it should exist as a field, not live only in someone's memory.

## Where this metadata lives

Prefer a structured sidecar file (JSON/YAML) alongside the raw data over embedding metadata only in a filename or a lab notebook — filenames should be human-scannable (see `data-file-naming-conventions`) but shouldn't be the only place the data lives, since filename length and characters are limited.

## Enforcement

This plugin's `PostToolUse` hook (`hooks/hooks.json`) reminds when a file is written under an `experiments/` directory to check it against this schema. That's a reminder, not a blocker — use judgment for intermediate/scratch files that aren't a final experiment record.
