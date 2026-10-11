# Build Engine API Contract

## Purpose

Communication contract between the Android Vibe Coding client and GitHub Actions.

## Build Request

```json
{
  "repository": "owner/project",
  "branch": "main",
  "platform": "android"
}
```

## Supported Platforms

- android
- linux
- windows

## Build Result

```json
{
  "status": "success",
  "platform": "android",
  "artifact": "app-release.apk",
  "logs": "build.log"
}
```

## Rules

- Every build must produce logs.
- Every artifact must be stored through GitHub Actions artifacts.
- Build execution remains stateless.
