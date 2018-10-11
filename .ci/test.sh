#!/bin/bash
set -xeo pipefail
cabal new-test all
cabal new-run -- clash-testsuite -j16
