#!/usr/bin/env bash

set -ex

# this makes sure that this script always runs in its own directory so that it pulls
# the right `.env`, for instance (this should also be an absolute path)
script_path="$(dirname "$(realpath "${BASH_SOURCE[0]:-$0}")")"
cd "$script_path"

# SYNC: path to directory where backups are stored
cd ./backups/

git add -A
# since we have `set -e`, we need to not commit if nothing was changed, as that exits with error
git diff-index --quiet HEAD || git commit -m "[autocommit] thank you github for free backups <3"
git push
