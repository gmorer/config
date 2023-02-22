#!/usr/bin/env bash
echo '
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH="/workdir/.cargo/bin:${PATH}"
' > ~/.zshrc

echo ${ZSHRC} > ~/.zshrc
# This has to be run only once to initialise the user
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
rustup component add rust-src
rustup component add rust-analyzer
