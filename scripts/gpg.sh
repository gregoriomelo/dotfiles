#!/usr/bin/env bash

set -e

echo "Importing private key"
gpg --import ~/.ssh/privkey.asc
