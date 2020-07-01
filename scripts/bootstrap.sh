#!/usr/bin/env sh

# Set git hooks

ln -s $(pwd)/scripts/hooks/pre-push $(pwd)/.git/hooks/pre-push
