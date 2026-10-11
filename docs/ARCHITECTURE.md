# Build Engine Architecture

## Purpose

Remote build infrastructure for the Android Vibe Coding environment.

## Flow

Android App -> GitHub Actions -> Build Runner -> Artifact -> Android App

## Responsibilities

- Trigger builds
- Prepare environments
- Compile projects
- Upload artifacts
- Return logs

This repository contains only build automation.

## Workspace ZIP uploads

NyVibeDroid can package the active Workspace as a ZIP and upload it as an asset of a temporary private draft release in this repository. The remote workflow validates and safely extracts that archive into its target directory, then runs the same Android Gradle builder. This path does not require a commit or push to the project's Git branch. The app token needs Actions: Read and write plus Contents: Read and write on the Build Engine repository for draft release creation, asset upload, and cleanup.

The app deletes the temporary release and tag once the workflow completes. A separate scheduled cleanup workflow removes any abandoned `nyvibe-workspace-*` draft releases after 24 hours. Workspace archives exclude `.git`, generated build/cache directories, local Android SDK settings, local `.env` files, and common private-key file types. The current size limits are 512 MiB uncompressed source and 200 MiB compressed ZIP. The archive extractor rejects path traversal and symlinks.
