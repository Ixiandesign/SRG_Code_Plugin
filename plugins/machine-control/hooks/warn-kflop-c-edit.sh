#!/bin/bash
# Advisory, non-blocking: KFlop C programs run in hard real time on the DSP board.
# Compiler quirks (TCC67) and timing constraints don't show up in normal review —
# flag every touch so a human checks it against the KFlop compile/timing constraints
# before it goes near the hardware.
input=$(cat)
file=$(jq -r '.tool_input.file_path // "unknown file"' <<<"$input")

jq -n --arg msg "Real-time KFlop C program touched ($file). Verify against KFlop/TCC67 compile and timing constraints before running on hardware — this runs on the DSP board, not the host PC." \
  '{ systemMessage: $msg, hookSpecificOutput: { hookEventName: "PreToolUse", additionalContext: $msg } }'
exit 0
