#!/usr/bin/env bash
set -euo pipefail

mkdir -p output

if [ -d target/output ]; then
  cp -r target/output/* output/ || true
fi

if [ -d target/build ]; then
  cp -r target/build/* output/ || true
fi

echo "Artifacts collected"
