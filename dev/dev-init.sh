#!/bin/bash

# packages
poetry install

# pre-commit hooks
pre-commit install

# commit-msg hook
ln -sf ../../git-hooks/commit-msg.py ./.git/hooks/commit-msg
chmod +x .git/hooks/commit-msg
