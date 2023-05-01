#!/bin/bash

files=(
  "01-install_dependencies.sh"
  "02-install_secp256k1.sh"
  "03-install_libsodium.sh"
  "04-install_haskell.sh"
  "05-clone_cardano_node.sh"
  "06-compile_cardano_node.sh"
  "07-setup_config.sh"
  "08-run_node.sh"
  "09-query_tip.sh"
)

for file in "${files[@]}"; do
  filename=$(basename "$file")
  curl -s "https://raw.githubusercontent.com/wowica/cardano-node-install/main/$file" -o "$file"
done
