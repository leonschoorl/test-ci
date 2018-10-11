#!/bin/bash
set -xeo pipefail
cabal new-update
cabal new-build all
