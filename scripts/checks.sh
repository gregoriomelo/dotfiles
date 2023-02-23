#!/usr/bin/env bash

set -e

echo "Checking for required dependencies before continuing..."
hash git 2>/dev/null || { echo "Error: git is not installed. Please install git first."; exit 1;}
hash curl 2>/dev/null || { echo "Error: curl is not installed. Please install curl first."; exit 1;}
hash ruby 2>/dev/null || { echo "Error: ruby is not installed. Please install stow first."; exit 1;}
hash brew 2>/dev/null || { echo "Installing Homebrew"; /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/gregoriomelo/.zprofile; eval "$(/opt/homebrew/bin/brew shellenv)"; }
