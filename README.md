# Foundry Starter Kit

<br/>
<p align="center">
<a href="https://chain.link" target="_blank">
<img src="./img/chainlink-foundry.png" width="225" alt="Chainlink Foundry logo">
</a>
</p>
<br/>

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/smartcontractkit/foundry-starter-kit)

Foundry Starter Kit is a repo that shows developers how to quickly build, test, and deploy smart contracts with one of the fastest frameworks out there, [foundry](https://github.com/gakonst/foundry)!

This repo is based on the [femplate](https://github.com/gakonst/femplate)

You can also check out the similar [dapptools-starter-kit](https://github.com/smartcontractkit/dapptools-starter-kit)

- [Foundry Starter Kit](#foundry-starter-kit)
- [Installation](#installation)
  - [Requirements](#requirements)
  - [Getting Started / Quickstart](#getting-started--quickstart)
  - [Testing](#testing)
- [Deploying to a network](#deploying-to-a-network)
  - [Setup](#setup)
  - [Deploying](#deploying)
- [Contributing](#contributing)
- [Thank You!](#thank-you)
  - [Resources](#resources)
    - [TODO](#todo)

# Installation

## Requirements

-   [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
-   [Foundry / Foundryup](https://github.com/gakonst/foundry)

And you probably already have `make` installed... but if not [try looking here.](https://askubuntu.com/questions/161104/how-do-i-install-make)

## Getting Started / Quickstart

```sh
git clone https://github.com/smartcontractkit/foundry-starter-kit.git
cd foundry-starter-kit
make # This installs the project's dependencies.
make test
```

## Testing

```
make test
```

or

```
forge test
```

# Deploying to a network

Deploying is done by a prompt system rather than a flexible single command to run at this time. If you'd like to contribute by writing some scripts to make deploying easier, please do!

## Setup

You'll need the following:

-   `RPC URL`: A URL to connect to the blockchain. You can get one for free from [Alchemy](https://www.alchemy.com/).
-   `Private Key`: A private key from your wallet. You can get a private key from a new [Metamask](https://metamask.io/) account
    -   Additionally, if you want to deploy to a testnet, you'll need test ETH and/or LINK. You can get them from [faucets.chain.link](https://faucets.chain.link/).
-   `Constructor Arguments`: These are the arguments that you pass to your smart contract on deployment. If you look at the `constructor` function in each contract, those are the values that they need. If you want some examples, we've provided some in our `scripts/helper-config.sh` file.
-   `Contract`: The name of the contract you want to deploy, ie `PriceFeedConsumer`.

## Deploying

```
bash scripts/deploy_<NETWORK>.sh
```

You'll be prompted for the following:

```
Enter Your Rinkeby RPC URL:
Example: https://eth-mainnet.alchemyapi.io/v2/XXXXXXXXXX

Which contract do you want to deploy (eg Greeter)?
Enter constructor arguments separated by spaces (eg 1 2 3):

compiling...
success.
Insert private key:
0x<PRIVATE_KEY_HERE>
```

Full Example:

```
bash scripts/deploy_rinkeby.sh

Enter Your Rinkeby RPC URL:
https://eth-rinkeby.alchemyapi.io/v2/XXXXXX

Which contract do you want to deploy (eg Greeter)?
PriceFeedConsumer

Enter constructor arguments separated by spaces (eg 1 2 3):
0x8A753747A1Fa494EC906cE90E9f37563A8AF630e

Insert private key:
0xXXXXXXX

Deployer: 0x643315c9be056cdea171f4e7b2222a4ddab9f88d
Deployed to: 0xec8af3f6c8725cc60e6ecc0009ad9e756e9723e0
```

# Contributing

Contributions are always welcome! Open a PR or an issue!

# Thank You!

## Resources

-   [Chainlink Documentation](https://docs.chain.link/)
-   [Foundry Documentation](https://onbjerg.github.io/foundry-book/)

### TODO

[ ] Make deployment more modular like in [dapptools-starter-kit](https://github.com/smartcontractkit/dapptools-starter-kit)

[ ] Enable network & contract choice from the command line

[ ] Add scripts that interact with deployed contracts

[ ] Add documentation for running on a local network with hardhat & a forked network
