#!/usr/bin/env bash
# Exits 1 when run inside the idea-to-demo template itself, so the pipeline
# never fills the template with project files. Projects created from the
# template have their own remote and folder name, so this passes there.
set -euo pipefail

TEMPLATE_NAME="idea-to-demo"

root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
origin="$(git -C "$root" remote get-url origin 2>/dev/null || true)"

if [[ -n "$origin" ]]; then
  repo="$(basename "${origin%.git}")"
else
  repo="$(basename "$root")"
fi

if [[ "$repo" == "$TEMPLATE_NAME" ]]; then
  cat >&2 <<MSG
This is the $TEMPLATE_NAME template, not a project. Don't run the pipeline here.
Create a project from it first, for example:

  gh repo create my-project --template KyungminYu/$TEMPLATE_NAME --private --clone

MSG
  exit 1
fi

echo "OK: $repo is a project repo."
