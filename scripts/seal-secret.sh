#!/bin/bash

# A script to simplify sealing Kubernetes secrets using kubeseal.
# It takes a secret YAML file as input and creates a corresponding
# SealedSecret YAML file.
#
# The script expects the input filename to end with '_secrets.yaml' and
# will create an output file with '_sealedsecrets.yaml' in its place.
#
# Usage:
# ./scripts/seal-secret.sh path/to/your_secrets.yaml
#
# Example:
# ./scripts/seal-secret.sh infra/base/pgsql/pgsql-backup_secrets.yaml

set -e
set -o pipefail

# --- Validation ---
if [ "$#" -ne 1 ]; then
    echo "Usage: $(basename "$0") <secret-yaml-file>"
    echo "Example: $(basename "$0") infra/base/pgsql/pgsql-backup_secrets.yaml"
    exit 1
fi

INPUT_FILE="$1"

if [ ! -f "$INPUT_FILE" ]; then
    echo "💥 Error: Input file '$INPUT_FILE' not found."
    exit 1
fi

OUTPUT_FILE="${INPUT_FILE/_secrets.yaml/_sealedsecrets.yaml}"

if [ "$INPUT_FILE" == "$OUTPUT_FILE" ]; then
    echo "💥 Error: Could not determine output filename. Input filename must end with '_secrets.yaml'."
    exit 1
fi

echo "Sealing '$INPUT_FILE' into '$OUTPUT_FILE'..."
kubeseal --format=yaml < "$INPUT_FILE" > "$OUTPUT_FILE"
echo "✅ Successfully created '$OUTPUT_FILE'."
