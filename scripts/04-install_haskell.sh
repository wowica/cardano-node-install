#!/bin/bash

BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
BOOTSTRAP_HASKELL_NO_UPGRADE=1 \
BOOTSTRAP_HASKELL_GHC_VERSION=8.10.7 \
BOOTSTRAP_HASKELL_CABAL_VERSION=3.6.2.0 \
BOOTSTRAP_HASKELL_ADJUST_BASHRC=1 \
bash <(curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org)

echo
echo "Finished installing Haskell"
echo