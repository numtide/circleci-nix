#!/usr/bin/env bash
set -euo pipefail

nix-build
docker load -i ./result
docker run -ti --rm circleci-nix:latest
