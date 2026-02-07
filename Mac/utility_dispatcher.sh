#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: dispatch <utility> [args...]"
  exit 1
}

[[ $# -ge 1 ]] || usage

utility="$1"
shift

util_path="$(command -v "$utility" || true)"
if [[ -z "$util_path" ]]; then
  echo "dispatch: utility not found: $utility" >&2
  exit 127
fi

before="$(pbpaste || true)"

"$util_path"

base="$(pbpaste || true)"

if [[ -z "$base" || "$base" == "$before" ]]; then
  echo "dispatch: '$utility' did not update the clipboard; nothing to execute." >&2
  exit 2
fi

if [[ $# -gt 0 ]]; then
  # Build a shell-escaped suffix from args
  suffix="$(printf '%q ' "$@")"
  full="$base $suffix"
else
  full="$base"
fi

exec bash -lc "$full"
