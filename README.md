# SRG_Code_Plugin

Claude Code plugin marketplace for the Schoop Research Group (Institute for Sustainable
Manufacturing, University of Kentucky). Ships standardized domain knowledge and tooling for the
group's custom 3-axis in-situ orthogonal cutting machine (KMotion/KFlop control, PFV4 high-speed
camera sync) and general lab coding conventions, so any lab project repo — and any AI coding tool
that reads `AGENTS.md` — gets the same context.

## Plugins

| Plugin | Covers |
|---|---|
| [`machine-control`](plugins/machine-control) | KMotion/KFlop CNC integration (C# UI ↔ `KMotion_dotNet.dll`), real-time KFlop C programs, G-code interpreter integration, orthogonal-cutting experiment configuration, PFV4/high-speed-camera trigger sync |
| [`lab-conventions`](plugins/lab-conventions) | Experiment metadata schema, data file naming, general coding best practices, and the `AGENTS.md` template new project repos bootstrap from |

A third plugin, `dic-piv-analysis` (NCORR/PIVlab/OpenPIV strain-field analysis), was scoped during
architecture planning but is deferred for now.

## Installing in a project repo

```
/plugin marketplace add <path-or-url-to-this-repo>
/plugin
```

Enable `lab-conventions` everywhere. Enable `machine-control` only in repos that actually touch the
motion-control/camera layer.

## Setting up a new project repo

See the `agents-md-project-bootstrap` skill in `lab-conventions` — it walks through copying
`plugins/lab-conventions/templates/AGENTS.md` into a new repo and wiring up `CLAUDE.md` as a one-line
`@AGENTS.md` import, so the same conventions read correctly across Claude Code, Cursor, Windsurf, and
other AGENTS.md-aware tools.

## Contributing to this repo

See [AGENTS.md](AGENTS.md).
