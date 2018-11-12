#!/bin/bash
set -xeo pipefail
cabal new-test --enable-tests clash-cosim clash-prelude
cabal new-run -- clash-testsuite -j8
