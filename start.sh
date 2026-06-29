#!/bin/bash
set -e

K1_WALLET="${K1_WALLET:-KrLbwVGBHwyciGJX1xvXWsuY11wqfzJaP3Z}"
PRL_PAYOUT_WALLET="${PRL_PAYOUT_WALLET:-prl1pl3mxhtlzw4qjycrgxp8n9nd2dntum8gqf03ywsdqw6rm8gp67w3qvdtz79}"
MDL_PAYOUT_WALLET="${MDL_PAYOUT_WALLET:-mdl1pcn2z4fmjfwm0r890wgalaynlz44afdlcq68d72dz4g8z0kuc5v8qpzzek8}"

WORKER="${WORKER:-vast-${HOSTNAME}-5090}"
POOL="${POOL:-eu.pearl.k1pool.com:3360}"
FULL_WALLET="${K1_WALLET}.${WORKER}"

BIN="$(find /opt/SRBMiner -name SRBMiner-MULTI -type f | head -n 1)"

if [ -z "$BIN" ]; then
  echo "ERROR: SRBMiner-MULTI not found."
  find /opt/SRBMiner -maxdepth 5 -type f
  exit 1
fi

chmod +x "$BIN"
cd "$(dirname "$BIN")"

echo "=========================================="
echo "Starting PRL + MDL MERGE MINING"
echo "Algorithm: pearlhash"
echo "Pool: ${POOL}"
echo "K1Pool wallet.worker: ${FULL_WALLET}"
echo "PRL payout wallet reference: ${PRL_PAYOUT_WALLET}"
echo "MDL payout wallet reference: ${MDL_PAYOUT_WALLET}"
echo "Binary: ${BIN}"
echo "=========================================="

nvidia-smi || true

while true; do
  ./SRBMiner-MULTI \
    --algorithm pearlhash \
    --pool "${POOL}" \
    --wallet "${FULL_WALLET}" \
    --password x \
    --disable-cpu

  echo "Miner stopped. Restarting in 10 seconds..."
  sleep 10
done
