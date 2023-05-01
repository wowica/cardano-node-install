#!/bin/bash

cardano-node run \
  --topology config/topology.json \
  --database-path db \
  --socket-path db/node.socket \
  --host-addr 0.0.0.0 \
  --port 3001 \
  --config config/config.json