FROM --platform=linux/amd64 rust@sha256:4277ce860337f6cfa1b679891bbf689a447f4b3f4f55701742614ad31321cee7

LABEL agave.version="v4.3.0"
RUN apt-get update && apt-get install -qy git gnutls-bin curl ca-certificates
RUN cargo install cargo-build-sbf --version 4.3.0 --locked
# Call cargo build-sbf to trigger installation of platform tools
RUN cargo init temp --edition 2021 && \
    cd temp && \
    cargo build-sbf --tools-version v1.57 && \
    rm -rf temp
WORKDIR /build

CMD /bin/bash
