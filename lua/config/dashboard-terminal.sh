#!/usr/bin/env bash

set -o pipefail

# Hard decision phase (no output allowed)
onefetch --version >/dev/null 2>&1
ONEFETCH_OK=$?

# Render phase (exactly ONE path)
if [ "$ONEFETCH_OK" -eq 0 ] && onefetch >/dev/null 2>&1; then
    onefetch
else
    pokemon-colorscripts -r --no-title
fi
