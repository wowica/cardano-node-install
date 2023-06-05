#!/bin/bash

mkdir config db

# Disables P2P
curl "https://book.world.dev.cardano.org/environments/preview/config.json" | sed 's/"EnableP2P": true/"EnableP2P": false/' > config/config.json
curl "https://book.world.dev.cardano.org/environments/preview/byron-genesis.json" > config/byron-genesis.json
curl "https://book.world.dev.cardano.org/environments/preview/shelley-genesis.json" > config/shelley-genesis.json
curl "https://book.world.dev.cardano.org/environments/preview/alonzo-genesis.json" > config/alonzo-genesis.json
# The following Topology file only works for P2P disabled nodes
cat << 'DONE' > config/topology.json
{
  "Producers": [
    {
      "addr": "preview-node.world.dev.cardano.org",
      "port": 30002,
      "valency": 1
    }
  ]
}
DONE

echo
echo "Finished copying node config for Preview Testnet and with P2P disabled"
echo
