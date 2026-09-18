#!/bin/bash
# Advisory, non-blocking: a file just landed under an experiments/ directory.
# Nudge toward the required metadata fields so runs stay traceable across the lab
# instead of relying on everyone remembering by hand.
input=$(cat)
file=$(jq -r '.tool_input.file_path // "unknown file"' <<<"$input")

jq -n --arg msg "New file under experiments/ ($file). Confirm it follows the experiment-metadata-schema (material, tool, cutting parameters, camera settings, operator, date) and data-file-naming-conventions skills." \
  '{ systemMessage: $msg }'
exit 0
