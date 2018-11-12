#!/bin/bash
set -xeo pipefail
apt-get update -q
apt-get install -yq cabal-install-head $GHC
cabal --version
ghc --version
cp .ci/project.cabal.local .
