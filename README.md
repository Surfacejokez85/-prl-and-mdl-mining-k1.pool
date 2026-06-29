# PRL + MDL Merge Miner for K1Pool

This Docker image mines

image mines PRL on K1Pool using SRBMiner pearlhash.

K1Pool PRL pool: Pearl Pool +MDL
Algorithm: pearlhash
Pool: stratum+tcp://eu.pearl.k1pool.com:3360

Miner uses K1Pool internal wallet/account:

KrLbwVGBHwyciGJX1xvXWsuY11wqfzJaP3Z

Payout wallets to add in K1Pool:

PRL:
prl1pl3mxhtlzw4qjycrgxp8n9nd2dntum8gqf03ywsdqw6rm8gp67w3qvdtz79

MDL:
mdl1pcn2z4fmjfwm0r890wgalaynlz44afdlcq68d72dz4g8z0kuc5v8qpzzek8

Run on Vast:

docker run -d \
  --name prl-mdl \
  --gpus all \
  --restart unless-stopped \
  -e K1_WALLET="KrLbwVGBHwyciGJX1xvXWsuY11wqfzJaP3Z" \
  -e WORKER="vast-1-5090" \
  -e POOL="stratum+tcp://eu.pearl.k1pool.com:3360" \
  jokez85/prl-wildrig-salad-builder:latest
