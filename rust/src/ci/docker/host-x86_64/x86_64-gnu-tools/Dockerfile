FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  g++ \
  make \
  ninja-build \
  file \
  curl \
  ca-certificates \
  python3 \
  git \
  cmake \
  libssl-dev \
  sudo \
  xz-utils \
  pkg-config

COPY scripts/sccache.sh /scripts/
RUN sh /scripts/sccache.sh

COPY host-x86_64/x86_64-gnu-tools/checktools.sh /tmp/

ENV RUST_CONFIGURE_ARGS \
  --build=x86_64-unknown-linux-gnu \
  --save-toolstates=/tmp/toolstate/toolstates.json
ENV SCRIPT /tmp/checktools.sh ../x.py
