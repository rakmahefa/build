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
