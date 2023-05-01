#!/bin/bash

echo
echo "Starting the compilation process."
echo "This takes around 30 mins on the recommended Cardano Node configuration"
echo

cd cardano-node
cabal update
cabal configure --with-compiler=ghc-8.10.7
time cabal build cardano-cli cardano-node

echo
echo "Finished compiling cardano node and cardano cli"
echo

mkdir -p $HOME/.cabal/bin
cp -p "$(./scripts/bin-path.sh cardano-node)" $HOME/.cabal/bin/
cp -p "$(./scripts/bin-path.sh cardano-cli)" $HOME/.cabal/bin/

echo "Run the following commands in order to check the installation:"
echo "cardano-cli --version"
echo "cardano-node --version"
echo