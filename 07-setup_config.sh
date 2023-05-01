#!/bin/bash

mkdir config db

curl "https://book.world.dev.cardano.org/environments/preview/config.json" | sed 's/"EnableP2P": true/"EnableP2P": false/' > config/config.json
curl "https://book.world.dev.cardano.org/environments/preview/byron-genesis.json" > config/byron-genesis.json
curl "https://book.world.dev.cardano.org/environments/preview/shelley-genesis.json" > config/shelley-genesis.json
curl "https://book.world.dev.cardano.org/environments/preview/alonzo-genesis.json" > config/alonzo-genesis.json
cat << 'DONE' > config/topology.json
{
  "Producers": [
    {
      "addr": "relay01.preview.junglestakepool.com",
      "port": 3001,
      "valency": 1
    }
  ]
}
DONE

echo
echo "Finished copying node config for Preview Testnet and with P2P disabled"
echo