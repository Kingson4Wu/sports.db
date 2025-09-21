#!/bin/bash
# lfs_clean.sh
# Usage:
#   ./lfs_clean.sh                 # Clean LFS files except those in local exclude.txt
#   ./lfs_clean.sh --update        # Update pointer files based on local exclude.txt
#   ./lfs_clean.sh <file>          # Restore a specific LFS file
#   ./lfs_clean.sh --reset         # Restore all LFS files
#   ./lfs_clean.sh --dirs dir1 dir2 # Restore only LFS files in specified directories

set -e

REPO_DIR=$(pwd)
EXCLUDE_FILE="$REPO_DIR/exclude.txt"

# Check if Git repository
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "[ERROR] Current directory is not a Git repository"
  exit 1
fi

# Check if Git LFS is installed
if ! command -v git-lfs &> /dev/null; then
  echo "[ERROR] Git LFS is not installed"
  exit 1
fi

# Disable only smudge hook
disable_smudge_hook() {
  if git config --local filter.lfs.smudge &> /dev/null; then
    git config --local filter.lfs.smudge "cat"
    echo "[INFO] LFS smudge hook disabled (pointer files will stay as pointers)."
  fi
}

# Restore LFS files except excluded ones
restore_lfs_files() {
  local exclude_file="$1"
  if [ ! -f "$exclude_file" ]; then
    echo "[WARN] Exclude file not found: $exclude_file. Restoring all LFS files."
    git lfs pull
    return
  fi

  echo "[INFO] Restoring LFS files except excluded paths from $exclude_file..."
  EXCLUDE_LIST=$(sed '/^\s*#/d;/^\s*$/d' "$exclude_file")  # remove comments and empty lines

  # Pull all LFS files
  git lfs pull

  # Convert excluded files back to pointers
  while IFS= read -r line; do
    # Trim whitespace
    line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    [ -z "$line" ] && continue
    if [ -f "$line" ] || [ -d "$line" ]; then
      git checkout -- "$line"
    fi
  done <<< "$EXCLUDE_LIST"

  echo "[INFO] Restore completed based on exclude.txt."
}

# Restore only specified directories
restore_lfs_dirs() {
  shift # remove --dirs
  DIRS=("$@")
  if [ ${#DIRS[@]} -eq 0 ]; then
    echo "[ERROR] No directories specified after --dirs"
    exit 1
  fi

  echo "[INFO] Restoring LFS files only in directories: ${DIRS[*]}"
  for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
      git lfs pull -I "$dir/**"
      echo "[INFO] Directory restored: $dir"
    else
      echo "[WARN] Directory not found: $dir"
    fi
  done
}

# Main logic
case "$1" in
  --reset)
    echo "[INFO] Restoring all LFS files to real content..."
    git lfs pull
    exit 0
    ;;
  --dirs)
    disable_smudge_hook
    restore_lfs_dirs "$@"
    exit 0
    ;;
  --update)
    disable_smudge_hook
    restore_lfs_files "$EXCLUDE_FILE"
    ;;
  *)
    if [ $# -eq 1 ]; then
      FILE="$1"
      echo "[INFO] Pulling LFS file: $FILE"
      git lfs pull -I "$FILE"
      echo "[INFO] Done: $FILE has been restored."
      exit 0
    else
      disable_smudge_hook
      restore_lfs_files "$EXCLUDE_FILE"
    fi
    ;;
esac

# Clean local LFS objects not used by any commit
git lfs prune
echo "[INFO] Cleanup done. Local LFS cache freed."