#!/bin/bash

CARDANO_NODE_SOCKET_PATH="$PWD/db/node.socket" cardano-cli query tip --testnet-magic 2
