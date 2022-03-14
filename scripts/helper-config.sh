#!/usr/bin/env bash

# Defaults to Rinkeby
interval=1
vrf_coordinator=0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
link_token=0x01be23585060835e02b77ef475b0cc51aa1e0709
keyhash=0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc # gasLane
fee=100000000000000000
price_feed=0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
oracle=0xc57b33452b4f7bb189bb5afae9cc4aba1f7a4fd8
jobId=6b88e0402e5d415eb946e528b8e0c7ba
# Add your subId here!
subId=1

# Defaults to Counter arguments
arguments=1

if [ "$NETWORK" = "kovan" ]
then 
    interval=1
    price_feed=0x9326BFA02ADD2366b30bacB125260Af641031331
    link_token=0xa36085F69e2889c224210F603D836748e7dC0088
    fee=100000000000000000
    oracle=0xc57b33452b4f7bb189bb5afae9cc4aba1f7a4fd8
    jobId=d5270d1c311941d0b08bead21fea7747
    # Add your subId here!
    subId=1
elif [ "$NETWORK" = "rinkeby" ]
then 
    interval=1
    vrf_coordinator=0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
    link_token=0x01be23585060835e02b77ef475b0cc51aa1e0709
    keyhash=0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc # gasLane
    fee=100000000000000000
    price_feed=0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
    oracle=0xc57b33452b4f7bb189bb5afae9cc4aba1f7a4fd8
    jobId=6b88e0402e5d415eb946e528b8e0c7ba
    # Add your subId here!
    subId=1
fi

if [ "$CONTRACT" = "Counter" ]
then 
    arguments=$interval
elif [ "$CONTRACT" = "PriceFeedConsumer" ]
then 
    arguments=$price_feed
elif [ "$CONTRACT" = "VRFConsumerV2" ]
then 
    arguments="$subId $vrf_coordinator $link_token $keyhash"
elif [ "$CONTRACT" = "APIConsumer" ]
then 
    arguments="$oracle $jobId $fee $link_token"
fi 
