#!/usr/bin/env bash
# Pulls the latest template-owned files into a project created from idea-to-demo.
# Project-owned files (REQUIREMENTS.md, specs/, app/, docs/, README.md, …) are never touched.
#
# Usage:
#   scripts/update-workflow.sh [template-git-url] [branch]
# The URL is only needed the first time; it's saved as the "template" remote.
set -euo pipefail

TEMPLATE_OWNED=(workflow roles AGENTS.md CLAUDE.md .claude .codex .agents scripts)

url="${1:-}"
branch="${2:-main}"

if ! git remote get-url template >/dev/null 2>&1; then
  if [[ -z "$url" ]]; then
    echo "No 'template' remote yet. Run: $0 https://github.com/KyungminYu/idea-to-demo.git" >&2
    exit 1
  fi
  git remote add template "$url"
fi

if [[ -n "$(git status --porcelain -- "${TEMPLATE_OWNED[@]}")" ]]; then
  echo "Uncommitted changes in template-owned files. Commit or stash them first:" >&2
  git status --short -- "${TEMPLATE_OWNED[@]}" >&2
  exit 1
fi

git fetch template "$branch"
git checkout "template/$branch" -- "${TEMPLATE_OWNED[@]}"

echo "Updated from template/$branch. Review, then commit:"
git status --short -- "${TEMPLATE_OWNED[@]}"
