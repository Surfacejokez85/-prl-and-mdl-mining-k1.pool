# PearlFortune PRL + MDL Merge Miner

Docker image for PearlFortune mining.

Pool:
global.pearlfortune.org:8888

PRL payout wallet:
prl1pl3mxhtlzw4qjycrgxp8n9nd2dntum8gqf03ywsdqw6rm8gp67w3qvdtz79

Important:
PearlFortune says MDL rewards are sent to the MDL address derived from the same seed phrase as the official PRL wallet.

Do not use:
- Exchange wallets
- Safe wallets
- Any wallet where you do not control the seed phrase/private keys

Vast.ai image:
jokez85/prl-wildrig-salad-builder:latest

Environment variables:
POOL=global.pearlfortune.org:8888
PRL_WALLET=your_prl_wallet
WORKER=vast-1-5090
GPUS=0,1,2,3
