# Build Engine

Remote build infrastructure for the mobile Vibe Coding environment.

## Goal

This repository provides GitHub Actions workflows and build scripts used to compile projects remotely from an Android development client.

## Architecture

```
Android Client
      |
      v
GitHub Actions
      |
      v
Build Runner
      |
      v
Artifacts + Logs
```

## Supported Targets

- Android
- Linux
- Windows

## Repository Rules

This repository contains only:

- CI/CD workflows
- Build scripts
- Build documentation

It does not contain application source code.
