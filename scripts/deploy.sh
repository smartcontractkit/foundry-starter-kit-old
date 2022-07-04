#!/usr/bin/env bash

# Read the Rinkeby RPC URL
echo Enter Your Mainnet RPC URL:
echo Example: "https://eth-mainnet.alchemyapi.io/v2/XXXXXXXXXX"
read -s rpc

# Read the contract name
echo Which contract do you want to deploy \(eg Greeter\)?
read contract

# Read the constructor arguments
echo Enter constructor arguments separated by spaces \(eg 1 2 3\):
read -r args

if [ ${#args} -eq 0 ]; then
    forge create ./src/${contract}.sol:${contract} -i --rpc-url $rpc
else
    forge create ./src/${contract}.sol:${contract} -i --rpc-url $rpc --constructor-args ${args}
fi
