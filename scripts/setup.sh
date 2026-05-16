#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd ..
if repo_root="$(git rev-parse --show-toplevel 2>/dev/null)"; then 
	echo "$repo_root" 
	echo 'as superproject found'
else
	echo 'No superproject found' >&2 
	exit 1
	
fi

python3 -m venv "$repo_root/venv"
"$repo_root/venv/bin/pip" install --upgrade pip
"$repo_root/venv/bin/pip" install openai

script_path="$script_dir/commit_messages.py"

if [[ ! -f "$script_path" ]]; then
  echo "Error: expected script not found: $script_path" >&2
  exit 1
fi

ln -sf "$script_path" "$repo_root/commitmessage"
chmod +x "$repo_root/commitmessage"
echo "symlink created: $repo_root/commitmessage -> $script_path"
