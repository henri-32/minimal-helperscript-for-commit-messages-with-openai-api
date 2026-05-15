#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

python3 -m venv "$repo_root/venv"
"$repo_root/venv/bin/pip" install --upgrade pip
"$repo_root/venv/bin/pip" install openai

script_path="$repo_root/commit_messages.py"

if [[ ! -f "$script_path" ]]; then
  echo "Error: expected script not found: $script_path" >&2
  exit 1
fi

ln -sf "$script_path" "$repo_root/commitmessage"
chmod +x "$repo_root/commitmessage"
echo "symlink created: $repo_root/commitmessage -> $script_path"
