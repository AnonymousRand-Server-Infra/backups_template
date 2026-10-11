#!/usr/bin/env bash

# double safeguard against deleting the wrong files
if [[ "$PWD" != '/home/ubuntu/git_server_db_backups_1' ]]; then
    echo "invalid working directory: $PWD"
    exit 1
fi

max_backup_count=12 # stores 2 days of backups at 4h per backup
ignored_files=(--ignore={"$(basename "$BASH_SOURCE")",.*})

backup_count="$(ls -1q "${ignored_files[@]}" | wc -l)"
if [[ "$backup_count" -gt "$max_backup_count" ]]; then
    ls "${ignored_files[@]}" -t \
            | tail --lines=+"$(expr "$max_backup_count" + 1)" \
            | xargs -d '\n' rm
fi
