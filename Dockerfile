FROM nvidia/cuda:12.8.1-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ARG SRB_VERSION=3.4.1

RUN apt-get update -y && apt-get install -y \
    curl jq tar ca-certificates pciutils htop nano \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN set -eux; \
    URL="$(curl -fsSL https://api.github.com/repos/doktor83/SRBMiner-Multi/releases/tags/${SRB_VERSION} \
      | jq -r '.assets[].browser_download_url' \
      | grep 'SRBMiner-Multi.*Linux.tar.gz' \
      | head -n 1)"; \
    echo "Downloading SRBMiner from: $URL"; \
    curl -L --retry 10 --retry-delay 5 -o srbminer.tar.gz "$URL"; \
    mkdir -p /opt/SRBMiner; \
    tar -xzf srbminer.tar.gz -C /opt/SRBMiner --strip-components=1 || tar -xzf srbminer.tar.gz -C /opt/SRBMiner; \
    find /opt/SRBMiner -name SRBMiner-MULTI -type f -exec chmod +x {} \; ; \
    test -n "$(find /opt/SRBMiner -name SRBMiner-MULTI -type f | head -n 1)"

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
