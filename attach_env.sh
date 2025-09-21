#!/usr/bin/env bash
set -e

source ~/anaconda3/etc/profile.d/conda.sh

ENV_NAME="sports.db"
YML_FILE="environment.yml"

if conda env list | grep -q "^\s*${ENV_NAME}\s"; then
    echo "Conda env '${ENV_NAME}' already exists, skipping creation."
else
    echo "Creating conda env '${ENV_NAME}' from ${YML_FILE}..."
    conda env create -f "${YML_FILE}"
fi

echo "Activating env '${ENV_NAME}'..."
conda activate "${ENV_NAME}"
