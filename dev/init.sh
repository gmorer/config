#!/usr/bin/env bash

# This has to be run only once to initialise the user
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="/workdir/.cargo/bin:${PATH}"
rustup component add rust-src
rustup component add rust-analyzer
