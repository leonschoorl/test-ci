#!/bin/bash
set -xeo pipefail
case "$GHC" in
  ghc-8.6* )
    # see https://github.com/haskell/haddock/issues/900
    echo "Haddock and doctests are broken on GHC 8.6, disabling"
    cp .ci/cabal.project.local-8.6 cabal.project.local
    ;;
  ghc-head )
    # singletons is broken on head: https://github.com/goldfirere/singletons/issues/357
    # This constraint on a future version makes the ghc-head build fail fast
    echo 'constraints: singletons > 2.5.1' >> cabal.project.local
  ;;
esac
