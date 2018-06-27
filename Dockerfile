FROM rust:1.27.0-slim

LABEL maintainer="Anthony Josiah Dodd <Dodd.AnthonyJosiah@gmail.com>"

# Install watcher extension.
RUN apt-get update && apt-get install -y ssh make pkg-config libssl-dev && \
    cargo install cargo-watch

# Copy over needed files.
WORKDIR /wither
COPY ./Cargo.lock Cargo.lock
COPY ./Cargo.toml Cargo.toml
COPY ./wither wither
COPY ./wither-derive wither-derive

RUN cargo build

# Use a CMD here (instead of ENTRYPOINT) for easy overwrite in docker ecosystem.
CMD ["cargo", "test", "--lib", "--tests"]
