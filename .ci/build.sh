#!/bin/bash
set -xeo pipefail
git submodule update --init --depth 1
cabal new-update
# workaround GHC bug 9221, see https://github.com/haskell-CI/haskell-ci/blob/f67bc41621d40d6559684be5406d65409df4c480/README.md#known-issues
sed -i 's/^jobs:/-- jobs:/' ${HOME}/.cabal/config
echo "store-dir: ${PWD}/cabal-store" >> ${HOME}/.cabal/config
cabal new-build all
