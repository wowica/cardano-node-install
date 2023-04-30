cat << 'EOF' > 01-install_dependencies.sh
#/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install automake build-essential pkg-config libffi-dev \
    libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make \
    g++ tmux git jq wget libncursesw5 libtool autoconf -y

echo ""
echo "Finished installing dependencies"
echo ""
EOF

chmod +x 01-install_dependencies.sh

cat << 'EOF' > 02-install_secp256k1.sh
#!/bin/bash

git clone https://github.com/bitcoin-core/secp256k1
cd secp256k1
git checkout ac83be33
./autogen.sh
./configure --enable-module-schnorrsig --enable-experimental
make
make check
sudo make install

echo ""
echo "Finished installing secp256k1"
echo ""
EOF

chmod +x 02-install_secp256k1.sh


cat << 'EOF' > 03-install_libsodium.sh
#!/bin/bash

git clone https://github.com/input-output-hk/libsodium
cd libsodium
git checkout 66f017f1
./autogen.sh
./configure
make
sudo make install

if [ -n "$BASH_VERSION" ]; then
  echo 'export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"' >> ~/.bashrc
  echo 'export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"' >> ~/.bashrc
  echo "Please source ~/.bashrc"

elif [ -n "$ZSH_VERSION" ]; then
  echo 'export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"' >> ~/.zshrc
  echo 'export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"' >> ~/.zshrc
  echo "Please source ~/.zshrc"

else
  cat <<EOM 
Unable to detect your shell. 
Please add the following two lines to the bottom of your shell profile/config file 
so that the compiler can be aware that libsodium is installed on your system.

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
EOM

fi

echo ""
echo "Finished installing libsodium"
echo ""
EOF

chmod +x 03-install_libsodium.sh

cat << 'EOF' > 04-clone_cardano_node.sh
#!/bin/bash

git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --recurse-submodules --tags
git checkout $(curl -s https://api.github.com/repos/input-output-hk/cardano-node/releases/latest | jq -r .tag_name)

echo ""
echo "Finished cloning cardano-node"
echo ""
EOF

chmod +x 04-clone_cardano_node.sh

cat << 'EOF' > 05-install_haskell.sh
#!/bin/bash

BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
BOOTSTRAP_HASKELL_NO_UPGRADE=1 \
BOOTSTRAP_HASKELL_GHC_VERSION=8.10.7 \
BOOTSTRAP_HASKELL_CABAL_VERSION=3.6.2.0 \
BOOTSTRAP_HASKELL_ADJUST_BASHRC=1 \
bash <(curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org)

echo ""
echo "Finished installing Haskell"
echo ""
EOF

chmod +x 05-install_haskell.sh

cat << 'EOF' > 06-compile_cardano_node.sh
#/bin/bash
cd cardano-node
cabal update
cabal configure --with-compiler=ghc-8.10.7
time cabal build cardano-cli cardano-node

echo ""
echo "Finished compiling cardano node and cardano cli"
echo ""
EOF

chmod +x 06-compile_cardano_node.sh

cat << 'EOF' > 07-setup_config.sh
#/bin/bash

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

echo ""
echo "Finished copying node config for Preview Testnet and with P2P disabled"
echo ""
EOF

chmod +x 07-setup_config.sh

cat << 'EOF' > 08-run_node.sh
#/bin/bash

#!/bin/bash

cardano-node run \
  --topology config/topology.json \
  --database-path db \
  --socket-path db/node.socket \
  --host-addr 0.0.0.0 \
  --port 3001 \
  --config config/config.json
EOF

chmod +x 08-run_node.sh