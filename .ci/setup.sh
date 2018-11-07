#!/bin/bash
set -xeo pipefail
apt-get update -q
apt-get install -yq cabal-install-head $GHC
cabal --version
ghc --version
cat > cabal.project.local << END_CABAL_PROJECT_LOCAL
package clash-testsuite
  flags: travisci
package *
  documentation: False
END_CABAL_PROJECT_LOCAL
cat cabal.project.local
