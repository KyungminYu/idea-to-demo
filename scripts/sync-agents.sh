#!/usr/bin/env bash
# Generates tool-specific files from single sources:
#   roles/*.md             -> .claude/agents/<name>.md    (Claude Code subagents)
#                          -> .codex/agents/<name>.toml   (Codex subagents)
#   .claude/commands/*.md  -> .agents/skills/<name>/SKILL.md (Codex skills)
# Run it after editing anything in roles/ or .claude/commands/.
#
# Role file format: frontmatter with name, description, sandbox (read-only |
# workspace-write) and claude_tools, followed by the instructions as Markdown.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

mkdir -p .claude/agents .codex/agents
rm -f .claude/agents/*.md .codex/agents/*.toml

field() { # field <file> <key>: value of a frontmatter key
  awk -v key="$2" '
    NR == 1 && $0 == "---" { in_fm = 1; next }
    in_fm && $0 == "---"   { exit }
    in_fm && index($0, key ":") == 1 { sub("^" key ":[ ]*", ""); print; exit }
  ' "$1"
}

body() { # body <file>: everything after the frontmatter, leading blank lines dropped
  awk '
    fm < 2 { if ($0 == "---") fm++; next }
    !started && $0 == "" { next }
    { started = 1; print }
  ' "$1"
}

for src in roles/*.md; do
  name="$(field "$src" name)"
  description="$(field "$src" description)"
  sandbox="$(field "$src" sandbox)"
  tools="$(field "$src" claude_tools)"
  instructions="$(body "$src")"

  if [[ -z "$name" || -z "$description" || -z "$sandbox" ]]; then
    echo "error: $src needs name, description and sandbox in its frontmatter" >&2
    exit 1
  fi
  if [[ "$instructions" == *"'''"* ]]; then
    echo "error: $src contains ''' which can't go in a TOML literal string" >&2
    exit 1
  fi

  note="Generated from $src by scripts/sync-agents.sh. Edit that file, not this one."

  {
    echo "---"
    echo "name: $name"
    echo "description: $description"
    [[ -n "$tools" ]] && echo "tools: $tools"
    echo "---"
    echo
    echo "<!-- $note -->"
    echo
    echo "$instructions"
  } > ".claude/agents/$name.md"

  escaped_description="${description//\\/\\\\}"
  escaped_description="${escaped_description//\"/\\\"}"
  {
    echo "# $note"
    echo "name = \"$name\""
    echo "description = \"$escaped_description\""
    echo "sandbox_mode = \"$sandbox\""
    echo "developer_instructions = '''"
    echo "$instructions"
    echo "'''"
  } > ".codex/agents/$name.toml"

  echo "synced $name"
done

# Codex has no project slash commands; it uses skills in .agents/skills/.
# Each .claude/commands/<name>.md becomes .agents/skills/<name>/SKILL.md,
# invoked in Codex with $<name> (e.g. $intake, $next).
rm -rf .agents/skills
mkdir -p .agents/skills
for src in .claude/commands/*.md; do
  name="$(basename "$src" .md)"
  description="$(field "$src" description)"
  instructions="$(body "$src" | sed 's/\$ARGUMENTS/anything the user wrote along with this request/g')"
  mkdir -p ".agents/skills/$name"
  {
    echo "---"
    echo "name: $name"
    echo "description: $description"
    echo "---"
    echo
    echo "<!-- Generated from $src by scripts/sync-agents.sh. Edit that file, not this one. -->"
    echo
    echo "$instructions"
  } > ".agents/skills/$name/SKILL.md"
  echo "synced skill $name"
done
