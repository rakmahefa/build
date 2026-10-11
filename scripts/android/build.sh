#!/usr/bin/env bash
set -euo pipefail

PROJECT_PATH=${1:-target}

mkdir -p output

if [ -f "$PROJECT_PATH/gradlew" ]; then
  cd "$PROJECT_PATH"
  chmod +x gradlew
  ./gradlew assembleRelease
  cp app/build/outputs/apk/release/*.apk ../output/ || true
else
  echo "No Gradle Android project detected"
fi
