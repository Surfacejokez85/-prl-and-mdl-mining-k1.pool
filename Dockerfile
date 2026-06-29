FROM nvidia/cuda:12.8.1-runtime-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl bash tar gzip coreutils procps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/tw-pearl-miner

RUN curl -fsSL https://github.com/egg5233/tw-pearl-miner/raw/main/install.sh | bash \
    && BIN="$(find /opt/tw-pearl-miner /root /usr/local/bin -type f -name 'pearl-gpu-miner' 2>/dev/null | head -n 1)" \
    && test -n "$BIN" \
    && cp "$BIN" /usr/local/bin/pearl-gpu-miner \
    && chmod +x /usr/local/bin/pearl-gpu-miner

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
