#!/bin/bash
set -xeo pipefail
# workaround GHC bug 9221, see https://github.com/haskell-CI/haskell-ci/blob/f67bc41621d40d6559684be5406d65409df4c480/README.md#known-issues
sed -i 's/^jobs:/-- jobs:/' ${HOME}/.cabal/config
echo "store-dir: ${PWD}/cabal-store" >> ${HOME}/.cabal/config
cabal new-update
cabal new-build all
cabal new-build $(ghc-pkg list --global --simple-output --names-only | sed 's/\([a-zA-Z0-9-]\{1,\}\) */--constraint="\1 installed" /g') all | sh
