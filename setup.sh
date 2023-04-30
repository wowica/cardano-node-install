cat << 'EOF' > install_dependencies.sh
#/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install automake build-essential pkg-config libffi-dev \
    libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make \
    g++ tmux git jq wget libncursesw5 libtool autoconf -y

echo "Finished installing dependencies"
EOF

cat << 'EOF' > install_secp256k1.sh
#!/bin/bash

git clone https://github.com/bitcoin-core/secp256k1
cd secp256k1
git checkout ac83be33
./autogen.sh
./configure --enable-module-schnorrsig --enable-experimental
make
make check
sudo make install

echo "Finished installing secp256k1"
EOF

chmod +x install_secp256k1.sh


cat << 'EOF' > install_libsodium.sh
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

echo "Finished installing libsodium"
EOF

chmod +x install_libsodium.sh

cat << 'EOF' > checkout_cardano_node.sh
#!/bin/bash

git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --recurse-submodules --tags
git checkout $(curl -s https://api.github.com/repos/input-output-hk/cardano-node/releases/latest | jq -r .tag_name)

echo "Finished cloning cardano-node"
EOF

chmod +x checkout_cardano_node.sh