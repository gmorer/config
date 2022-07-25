#!/usr/bin/env bash

# https://github.com/wbthomason/packer.nvim/issues/198
# Async install of the packages is not working in headless mod ATM
# Y ou should run :PackerSync once in nvim

echo "Depend on go rust clang, nice nerd fonts..."

mkdir -p ${HOME}/.local/bin \
&& curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o ${HOME}/.local/bin/nvim \
&& chmod +x ${HOME}/.local/bin/nvim \
&& git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim \
&& mkdir -p ${HOME}/.local/share/nvim/site/pack/packer/start/ \
&& rm -rf ${HOME}/.config/nvim \
&& ln -fs  ${PWD}/resources ${HOME}/.config/nvim
