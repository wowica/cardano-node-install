# Cardano Node Install

This project aims to provide helper scripts for installing and running Cardano Node on a Linux machine for the Preview Testnet Environment. It has been tested on an Ubuntu Server 22.04 with Cardano Node version 1.35.7.

The scripts are based on the Official Cocs available on the [Cardano Developers Portal](https://developers.cardano.org/docs/get-started/installing-cardano-node)

Running the following command will download and create individual script files on your local file system, which you will then be required to run yourself:

`curl -s https://raw.githubusercontent.com/wowica/cardano-node-install/main/setup.sh | bash -`

Running the command above will NOT execute any of the scripts. It should produce the following structure:

```
ubuntu@node:~$ tree -L 1
.
├── 01-install_dependencies.sh
├── 02-install_secp256k1.sh
├── 03-install_libsodium.sh
├── 04-clone_cardano_node.sh
├── 05-install_haskell.sh
├── 06-compile_cardano_node.sh
├── 07-setup_config.sh
├── 08-run_node.sh
└── 09-query_tip.sh

0 directories, 9 files
```