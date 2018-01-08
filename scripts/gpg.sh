#!/usr/bin/env bash

set -e

echo "Importing private key"
gpg --import ~/.ssh/privkey.asc
gpg --edit-key AA5C942FC9EC5C90
