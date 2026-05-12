.PHONY: setup run

setup: 
	@scripts/setup.sh

run:
	@venv/bin/python commit_messages.py
