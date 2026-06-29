#!/usr/bin/env bash
set -euo pipefail

POOL="${POOL:-global.pearlfortune.org:8888}"
PRL_WALLET="${PRL_WALLET:-${WALLET:-}}"
WORKER="${WORKER:-vast-$(hostname)}"

echo "=========================================="
echo "Starting PearlFortune PRL + MDL mining"
echo "Miner: tw-pearl-miner / pearl-gpu-miner"
echo "Pool: $POOL"
echo "Worker: $WORKER"
echo "PRL wallet: $PRL_WALLET"
echo "=========================================="

if [[ -z "$PRL_WALLET" ]]; then
  echo "ERROR: PRL_WALLET is missing."
  echo "Set PRL_WALLET to your prl1... wallet address in Vast."
  exit 1
fi

if [[ "$PRL_WALLET" != prl1* ]]; then
  echo "ERROR: PearlFortune needs your official PRL wallet beginning with prl1..."
  echo "Do NOT use the K1Pool KrL... account here."
  exit 1
fi

nvidia-smi || true

exec pearl-gpu-miner \
  --pool "$POOL" \
  --wallet "$PRL_WALLET" \
  --worker "$WORKER" \
  --no-tui
