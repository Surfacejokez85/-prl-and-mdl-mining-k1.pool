#!/usr/bin/env bash
set -euo pipefail

POOL="${POOL:-global.pearlfortune.org:8888}"
PRL_WALLET="${PRL_WALLET:-prl1pl3mxhtlzw4qjycrgxp8n9nd2dntum8gqf03ywsdqw6rm8gp67w3qvdtz79}"
WORKER="${WORKER:-vast-$(hostname | cut -c1-8)}"
GPUS="${GPUS:-}"
EXTRA_ARGS="${EXTRA_ARGS:-}"

export LD_LIBRARY_PATH="/opt/tw-pearl-miner:${LD_LIBRARY_PATH:-}"
cd /opt/tw-pearl-miner

echo "=========================================="
echo "Starting PearlFortune PRL + MDL mining"
echo "Miner: tw-pearl-miner / pearl-gpu-miner"
echo "Pool: $POOL"
echo "Worker: $WORKER"
echo "PRL wallet: $PRL_WALLET"
echo "MDL note: PearlFortune derives MDL from the same official PRL wallet seed."
echo "=========================================="

nvidia-smi || true

CMD=(./pearl-gpu-miner --pool "$POOL" --wallet "$PRL_WALLET" --worker "$WORKER" --no-tui --pf)

if [ -n "$GPUS" ]; then
  CMD+=(--gpus "$GPUS")
fi

if [ -n "$EXTRA_ARGS" ]; then
  # Allows optional args like: EXTRA_ARGS="--gpus 0,1"
  read -r -a EXTRA_ARRAY <<< "$EXTRA_ARGS"
  CMD+=("${EXTRA_ARRAY[@]}")
fi

echo "Running:"
printf '%q ' "${CMD[@]}"
echo
echo "=========================================="

exec "${CMD[@]}"
