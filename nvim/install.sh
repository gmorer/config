#!/usr/bin/env bash

echo "Depend on go rust clang, nice nerd fonts..."

mkdir -p ${HOME}/.local/bin \
&& curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o ${HOME}/.local/bin/nvim \
&& chmod +x ${HOME}/.local/bin/nvim \
&& rm -rf ${HOME}/.config/nvim \
&& ln -fs  ${PWD}/resources ${HOME}/.config/nvim
