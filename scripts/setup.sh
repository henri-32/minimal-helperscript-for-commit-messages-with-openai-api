#!/usr/bin/env bash
set -euo pipefail
repo_root = $(git rev-parse --show-toplevel)

python3 -m venv venv
venv/bin/pip install --upgrade pip 
venv/bin/pip install openai


