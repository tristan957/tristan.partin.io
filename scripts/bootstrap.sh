#!/bin/sh

# Set git hooks

ln -s $(pwd)/scripts/hooks/pre-push $(pwd)/.git/hooks/pre-push
ln -s $(pwd)/scripts/hooks/pre-commit $(pwd)/.git/hooks/pre-commit
