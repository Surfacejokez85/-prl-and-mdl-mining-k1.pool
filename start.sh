#!/bin/bash
set -e

POOL="${POOL:-global.pearlfortune.org:8888}"
PRL_WALLET="${PRL_WALLET:-prl1pl3mxhtlzw4qjycrgxp8n9nd2dntum8gqf03ywsdqw6rm8gp67w3qvdtz79}"
WORKER="${WORKER:-vast-${HOSTNAME}-5090}"
GPUS="${GPUS:-}"

BIN="$(find /opt/tw-pearl-miner -type f -name 'pearl-gpu-miner*' | head -n 1)"

if [ -z "$BIN" ]; then
  echo "ERROR: pearl-gpu-miner not found."
  find /opt/tw-pearl-miner -maxdepth 5 -type f
  exit 1
fi

chmod +x "$BIN"
cd "$(dirname "$BIN")"

echo "=========================================="
echo "Starting PearlFortune PRL + MDL merge mining"
echo "Pool: ${POOL}"
echo "PRL payout wallet: ${PRL_WALLET}"
echo "Worker: ${WORKER}"
echo "Miner: ${BIN}"
echo ""
echo "IMPORTANT:"
echo "PearlFortune says MDL rewards are sent to the MDL address"
echo "derived from the SAME SEED PHRASE as this PRL wallet."
echo "Do NOT use exchange/Safe/K1 wallet addresses here."
echo "Do NOT paste your seed phrase anywhere."
echo "=========================================="

nvidia-smi || true

ARGS=(
  --pool "${POOL}"
  --wallet "${PRL_WALLET}"
  --worker "${WORKER}"
  --pf
  --no-tui
)

if [ -n "$GPUS" ]; then
  ARGS+=(--gpus "$GPUS")
fi

while true; do
  echo "Running command:"
  echo "$BIN ${ARGS[*]}"
  "$BIN" "${ARGS[@]}"

  echo "Miner stopped/crashed. Restarting in 10 seconds..."
  sleep 10
done
