# Cardano Node Install

This project aims to provide helper scripts for installing and running a Cardano Relay Node on a Linux machine for the **Preview Testnet** Environment. It has been tested on an **Ubuntu Server 22.04** with Cardano Node version **1.35.7** with PSP disabled.

The scripts are based on the Official Documentation available on the [Cardano Developers Portal](https://developers.cardano.org/docs/get-started/installing-cardano-node)

## Installing

Clone this repo or run the script below to download the script files to your local file system.

`curl -s https://raw.githubusercontent.com/wowica/cardano-node-install/main/setup.sh | bash -`

Running the command above will strictly download the scripts. It will NOT execute them. You are required to do this yourself.

## Disclaimer

🚨 These scripts are for educational purposes only. They are meant to help teach developers how to start working with Cardano. 

For those planning on running infrastructure which critical services will depend on, please consider following a more robust approach such as the one recommended by [Guild Operators](https://cardano-community.github.io/guild-operators/).