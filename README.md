# Build Engine

Reusable GitHub Actions workflow and scripts for remote builds requested by NyVibeDroid.

## Current support

| Target | Status | Output |
| --- | --- | --- |
| Android Gradle app | Enabled | Debug and release APKs, build log, metadata |
| Linux | Disabled | Builder not implemented |
| Windows | Disabled | Builder not implemented |

The workflow only offers targets that are implemented. Unsupported targets fail explicitly rather than reporting a successful build without producing a binary.

## Run a remote build

1. Open **Actions → Remote Build Engine → Run workflow**.
2. Enter the target GitHub repository in `owner/name` format.
3. Enter the branch, tag, or commit ref.
4. Select **android** and run the workflow.
5. Download the `build-android` artifact, which contains APKs under `apks/`, `build.log`, the complete `engine-run.log`, build metadata, and any collected project logs.

The target must be an Android Gradle project with `settings.gradle(.kts)` and an application module at `app/build.gradle(.kts)`. The runner uses JDK 17 and Gradle 8.9 when the target has no Gradle Wrapper; an existing project wrapper is preferred.

Public target repositories work with the default workflow token. For private target repositories, add a read-only `BUILD_TARGET_TOKEN` Actions secret to this repository. The token must have contents-read access to the target repository.

## Workflow guarantees

- Runs tests before assembling debug and release APKs.
- Fails if project configuration fails or no APK is produced.
- Preserves build logs and metadata even when the build fails.
- Uploads diagnostics as a GitHub Actions artifact on success or failure.
- Does not silently claim Linux or Windows support before those build pipelines are implemented.

## Repository rules

This repository contains only build workflows, scripts, configuration, and documentation. Application source belongs in the target project repository.
