FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    lib32gcc-s1 \
    lib32stdc++6 \
    libncurses5:i386 \
    libcurl4-gnutls-dev:i386 \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m starbound
USER starbound

WORKDIR /home/starbound
