#!/usr/bin/env bash
set -euo pipefail

ENGINE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUTPUT_DIR="$ENGINE_ROOT/output"
TARGET_DIR="$ENGINE_ROOT/target"

mkdir -p "$OUTPUT_DIR/logs" "$OUTPUT_DIR/apks"

if [[ -d "$TARGET_DIR/output" ]]; then
  cp -a "$TARGET_DIR/output/." "$OUTPUT_DIR/"
fi

if [[ -d "$TARGET_DIR/logs" ]]; then
  cp -a "$TARGET_DIR/logs/." "$OUTPUT_DIR/logs/"
fi

if [[ -d "$TARGET_DIR" ]]; then
  find "$TARGET_DIR" -type f -name '*.log' \
    -not -path '*/.gradle/*' \
    -not -path '*/build/*' \
    -exec cp -n {} "$OUTPUT_DIR/logs/" \;
fi

if [[ -f "$OUTPUT_DIR/build.log" ]]; then
  cp "$OUTPUT_DIR/build.log" "$OUTPUT_DIR/logs/android-build.log"
fi

echo "Artifact collection finished."
