# Build Engine Workflow Contract

## Request

The `Remote Build Engine` GitHub Actions workflow is started manually from the Actions tab.

```json
{
  "repository": "owner/project",
  "branch": "main",
  "platform": "android"
}
```

- `repository`: GitHub repository in `owner/name` format.
- `branch`: branch, tag, or commit ref. Defaults to `main`.
- `platform`: currently only `android` is enabled.

## Android build requirements

The target must contain `settings.gradle` or `settings.gradle.kts`, plus `app/build.gradle` or `app/build.gradle.kts`. The workflow sets up JDK 17 and Gradle 8.9, then runs:

```bash
gradle --no-daemon clean test assembleDebug assembleRelease
```

A checked-in Gradle Wrapper is preferred and used when present.

## Result artifact

The `build-android` Actions artifact includes:

- `apks/`: all generated APKs, preserving their project output paths
- `build.log`: Gradle output captured by the Android builder
- `engine-run.log`: complete Android builder stdout/stderr, including validation failures before Gradle starts
- `logs/`: additional project logs, when available
- `build-metadata.txt`: repository, requested ref, resolved commit, platform, job outcome, and workflow URL

A build is successful only if Gradle succeeds and at least one APK is produced. The artifact is uploaded even on failure so logs and metadata remain available.

## Access

Public repositories can be checked out using the workflow token. For a private target repository, configure a read-only `BUILD_TARGET_TOKEN` repository Actions secret in this Build Engine repository.

Linux and Windows are not available targets yet and remain disabled in `configs/build.json` until working builders are implemented and tested.
