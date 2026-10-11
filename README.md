# Build Engine

Reusable GitHub Actions workflow and scripts for remote builds requested by NyVibeDroid.

## Current support

| Target | Status | Output |
| --- | --- | --- |
| Android Gradle app | Enabled | Debug and release APKs, build log, metadata |
| Linux | Disabled | Builder not implemented |
| Windows | Disabled | Builder not implemented |

The workflow only offers targets that are implemented. Unsupported targets fail explicitly rather than reporting a successful build without producing a binary.

## Use it from NyVibeDroid

The NyVibeDroid Android app includes a **Remote Build** screen that triggers this repository's Remote Build Engine workflow, tracks the run, displays logs, and downloads the debug APK to the phone.

1. Create a fine-grained GitHub personal access token for this repository.
2. Grant the token **Actions: Read and write** permission on this Build Engine repository. Keep it private.
3. In NyVibeDroid, enter and validate the token. The app encrypts it using Android Keystore on the device.
4. Select the target repository in owner/name format and a branch, tag, or commit.
5. Start the Android build, then inspect the run/logs or download the debug APK from within the app.

For a private target repository, also create a read-only BUILD_TARGET_TOKEN Actions secret in this repository, with Contents: read access to the target project. The app token is used for the GitHub Actions API and is not passed to the target project's build process.

The app currently supports Android Gradle builds only; Linux and Windows remain disabled until their builders can produce real, verified binaries.

## Run a remote build manually

1. Open **Actions → Remote Build Engine → Run workflow**.
2. Enter the target GitHub repository in owner/name format.
3. Enter the branch, tag, or commit ref.
4. Select **android** and run the workflow.
5. Download the build-android artifact, which contains APKs under apks/, build.log, the complete engine-run.log, build metadata, and any collected project logs.

The target must be an Android Gradle project with settings.gradle(.kts) and an application module at app/build.gradle(.kts). The runner uses JDK 17 and Gradle 8.9 when the target has no Gradle Wrapper; an existing project wrapper is preferred.

Public target repositories work with the default workflow token. For private target repositories, add the read-only BUILD_TARGET_TOKEN Actions secret described above.

## Workflow guarantees

- Runs tests before assembling debug and release APKs.
- Fails if project configuration fails or no APK is produced.
- Preserves build logs and metadata even when the build fails.
- Uploads diagnostics as a GitHub Actions artifact on success or failure.
- Does not silently claim Linux or Windows support before those build pipelines are implemented.

## Repository rules

This repository contains only build workflows, scripts, configuration, and documentation. Application source belongs in the target project repository.
