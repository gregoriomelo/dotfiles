#!/usr/bin/env bash

# Check if ollama is running
if ! pgrep -x "ollama" > /dev/null; then
    echo "Ollama is not running. Starting it..."
    # On macOS, start the app or CLI
    open -a Ollama
    # Wait for it to be ready
    echo "Waiting for Ollama to be ready..."
    max_retries=10
    count=0
    until ollama list &> /dev/null || [ $count -eq $max_retries ]; do
        sleep 2
        ((count++))
    done
fi

if ! command -v ollama &> /dev/null; then
    echo "Ollama is not installed. Skipping model pull."
    exit 0
fi

# Ask to pull Qwen (the best coding model for this machine)
read -p "Do you want to pull the Qwen3-Coder:30b-a3b model (19GB)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Pulling Qwen3-Coder:30b-a3b..."
    ollama pull qwen3-coder:30b-a3b
else
    echo "Skipped pulling Qwen."
fi
