#!/usr/bin/env bash
set -euo pipefail

echo "Preparing build environment"

sudo apt-get update
sudo apt-get install -y zip unzip file

mkdir -p output

echo "Build environment ready"
