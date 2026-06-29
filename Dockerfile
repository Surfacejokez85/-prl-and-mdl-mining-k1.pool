FROM nvidia/cuda:12.8.1-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV MINER_DIR=/opt/tw-pearl-miner
ENV LD_LIBRARY_PATH=/opt/tw-pearl-miner:${LD_LIBRARY_PATH}

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget tar gzip bash procps pciutils \
    && rm -rf /var/lib/apt/lists/*

ARG TW_PEARL_VERSION=2.2.6

RUN set -eux; \
    mkdir -p /tmp/tw-pearl /opt/tw-pearl-miner; \
    curl -fL "https://github.com/egg5233/tw-pearl-miner/releases/download/v${TW_PEARL_VERSION}/tw-pearl-miner-${TW_PEARL_VERSION}.c12.tar.gz" -o /tmp/tw-pearl.tar.gz; \
    tar -xzf /tmp/tw-pearl.tar.gz -C /tmp/tw-pearl; \
    MINER_FOLDER="$(dirname "$(find /tmp/tw-pearl -type f -name pearl-gpu-miner | head -n 1)")"; \
    cp -a "$MINER_FOLDER/." /opt/tw-pearl-miner/; \
    chmod +x /opt/tw-pearl-miner/pearl-gpu-miner; \
    test -f /opt/tw-pearl-miner/pearl-gpu-miner; \
    test -f /opt/tw-pearl-miner/libpearlkernel.so; \
    rm -rf /tmp/tw-pearl /tmp/tw-pearl.tar.gz

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
