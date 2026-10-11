#!/usr/bin/env bash

set -ex

# this makes sure that this script always runs in its own directory so that it pulls
# the right `.env`, for instance (this should also be an absolute path)
script_path="$(dirname "$(realpath "${BASH_SOURCE[0]:-$0}")")"
cd "$script_path"

source ./.env

# double safeguard against deleting the wrong files
if [[ "$PWD" != "$CURR_PWD" ]]; then
    echo "invalid working directory: $PWD"
    exit 1
fi

cd "$BACKUPS_DIR"

ignored_files=()
for pattern in "${BACKUPS_IGNORED_FILES[@]}"; do
    ignored_files+=("--ignore" "$pattern")
done

backup_count="$(ls -1q "${ignored_files[@]}" | wc -l)"
if [[ "$backup_count" -gt "$MAX_BACKUP_COUNT" ]]; then
    ls "${ignored_files[@]}" -t \
            | tail --lines=+"$(expr "$MAX_BACKUP_COUNT" + 1)" \
            | xargs -d '\n' rm
fi
