#!/bin/bash
set -xeo pipefail
git submodule update --init --depth 1
cabal new-update
cabal new-build all
