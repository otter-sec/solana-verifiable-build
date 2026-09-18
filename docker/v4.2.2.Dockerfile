FROM --platform=linux/amd64 rust@sha256:897292968f3e2c7aaba68bf8e6239b61994a8adbdd09e49bd866b69822b98af9

LABEL agave.version="v4.2.2"
RUN apt-get update && apt-get install -qy git gnutls-bin curl ca-certificates
# cargo-build-sbf 4.2.0 is the crate pin for the Agave 4.2.x train
RUN cargo install cargo-build-sbf --version 4.2.0 --locked
# Call cargo build-sbf to trigger installation of platform tools
RUN cargo init temp --edition 2021 && \
    cd temp && \
    cargo build-sbf --tools-version v1.56 && \
    rm -rf temp
WORKDIR /build

CMD /bin/bash
