#!/usr/bin/env python3

from openai import OpenAI
import subprocess

client = OpenAI()

myinput = (
    "Based on the staged git diff below, write one Conventional Commit message "
    "in English. "
    "Rules: "
    "Format: <type>(optional-scope): <subject>. "
    "Use lowercase type from: feat, fix, docs, style, refactor, test, chore, "
    "ci, build, perf. "
    "Subject in imperative mood, max 72 characters, no trailing period. "
    "Reflect only the staged changes. "
    "Output only the commit message, no code fences or explanation. "
    "Staged diff:"
)

diff_proc = subprocess.Popen(
    ["git", "diff", "--cached", "--unified=0"],
    stdout=subprocess.PIPE,
    text=True,
)

diff, _ = diff_proc.communicate()

if not diff.strip(): 
    print("Nothing staged for commit") 
    raise SystemExit(0) 

print("openai call...\n"
    "commit message:\n") 


response = client.responses.create(
    model = "gpt-4.1-mini",
    input = myinput + "\n\n" + diff,
)

commit_message = response.output_text
print(commit_message, flush=True)

answer = input("\napprove commit message? (y/n): ").strip().lower()
print ("\n")

if answer == "y":
    subprocess.run(["git", "commit", "-m", commit_message], check=True)
    print("\nchanges committed with generated commit message")
else:
    print("exited")


        
    
	
