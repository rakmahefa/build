#!/usr/bin/env bash
set -euo pipefail

ENGINE_ROOT="$(pwd)"
OUTPUT_DIR="$ENGINE_ROOT/output"
PROJECT_PATH="${1:-target}"

if [[ "$PROJECT_PATH" != /* ]]; then
  PROJECT_PATH="$ENGINE_ROOT/$PROJECT_PATH"
fi

mkdir -p "$OUTPUT_DIR/apks"

if [[ ! -d "$PROJECT_PATH" ]]; then
  echo "Target project directory does not exist: $PROJECT_PATH" >&2
  exit 2
fi

if [[ ! -f "$PROJECT_PATH/settings.gradle" && ! -f "$PROJECT_PATH/settings.gradle.kts" ]]; then
  echo "Target is not a Gradle project: settings.gradle(.kts) was not found." >&2
  exit 2
fi

if [[ ! -f "$PROJECT_PATH/app/build.gradle" && ! -f "$PROJECT_PATH/app/build.gradle.kts" ]]; then
  echo "Expected an Android app module at app/build.gradle(.kts)." >&2
  exit 2
fi

if [[ -f "$PROJECT_PATH/gradlew" ]]; then
  echo "Using the project's Gradle Wrapper."
  (
    cd "$PROJECT_PATH"
    chmod +x ./gradlew
    ./gradlew --no-daemon clean test assembleDebug assembleRelease
  ) 2>&1 | tee "$OUTPUT_DIR/build.log"
elif command -v gradle >/dev/null 2>&1; then
  echo "No Gradle Wrapper found; using the pinned Gradle distribution installed by the workflow."
  (
    cd "$PROJECT_PATH"
    gradle --no-daemon clean test assembleDebug assembleRelease
  ) 2>&1 | tee "$OUTPUT_DIR/build.log"
else
  echo "Gradle is unavailable. Install a wrapper or configure Gradle in the workflow." >&2
  exit 127
fi

apk_count=0
while IFS= read -r -d '' apk_path; do
  relative_path="${apk_path#"$PROJECT_PATH/"}"
  destination="$OUTPUT_DIR/apks/$relative_path"
  mkdir -p "$(dirname "$destination")"
  cp "$apk_path" "$destination"
  apk_count=$((apk_count + 1))
done < <(find "$PROJECT_PATH" -type f -path '*/build/outputs/apk/*.apk' -print0)

if [[ "$apk_count" -eq 0 ]]; then
  echo "The build finished without producing any APK. Failing the job." >&2
  exit 1
fi

echo "Copied $apk_count APK file(s) to $OUTPUT_DIR/apks."
