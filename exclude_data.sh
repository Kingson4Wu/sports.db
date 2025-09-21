#!/bin/bash

set -e

DIR_FILE="dir.txt"
EXCLUDE_FILE="exclude.txt"

if [[ ! -f "$DIR_FILE" ]]; then
    echo "Error: $DIR_FILE not found in current directory."
    exit 1
fi

# 如果 exclude.txt 存在，就加载排除目录到数组
EXCLUDE_DIRS=()
if [[ -f "$EXCLUDE_FILE" ]]; then
    while IFS= read -r line || [[ -n "$line" ]]; do
        dir=$(echo "$line" | xargs)
        if [[ -n "$dir" ]]; then
            EXCLUDE_DIRS+=("$dir")
        fi
    done < "$EXCLUDE_FILE"
fi

git sparse-checkout init --cone

KEEP_DIRS=()
while IFS= read -r line || [[ -n "$line" ]]; do
    dir=$(echo "$line" | xargs)
    if [[ -n "$dir" ]]; then
        skip=false
        for ex in "${EXCLUDE_DIRS[@]}"; do
            if [[ "$dir" == "$ex" ]]; then
                skip=true
                break
            fi
        done
        if [[ "$skip" == false ]]; then
            KEEP_DIRS+=("$dir")
        fi
    fi
done < "$DIR_FILE"

if [ ${#KEEP_DIRS[@]} -eq 0 ]; then
    echo "No directories to keep after excluding configured dirs. Exiting."
    exit 0
fi

echo "Running: git sparse-checkout set ${KEEP_DIRS[*]}"
git sparse-checkout set "${KEEP_DIRS[@]}"

if [[ ${#EXCLUDE_DIRS[@]} -gt 0 ]]; then
    echo "Sparse-checkout setup complete. Excluded: ${EXCLUDE_DIRS[*]}"
else
    echo "Sparse-checkout setup complete. No exclusions applied."
fi
