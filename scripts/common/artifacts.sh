#!/usr/bin/env bash
set -euo pipefail

mkdir -p output logs

if [ -d target/output ]; then
  cp -r target/output/* output/ 2>/dev/null || true
fi

if [ -d target/build ]; then
  cp -r target/build/* output/ 2>/dev/null || true
fi

find . -name '*.log' -exec cp {} logs/ \; 2>/dev/null || true

echo "Artifacts collected"
