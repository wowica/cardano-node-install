#!/bin/bash

git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --recurse-submodules --tags
git checkout 8.1.1

echo
echo "Finished cloning cardano-node"
echo
