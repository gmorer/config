#!/usr/bin/env bash

echo "Depend on go rust clang, nice nerd fonts..."

mkdir -p ${HOME}/bin \
&& curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o ${HOME}/bin/nvim \
&& chmod +x ${HOME}/bin/nvim \
&& mkdir -p ${HOME}/.local/share/nvim/site/pack/packer/start/ \
&& git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim \
&& rm -rf ${HOME}/.config/nvim \
&& ln -fs  ${PWD}/resources ${HOME}/.config/nvim
# && nvim --headless +PlugInstall +qall \
# && ${HOME}/.local/share/nvim/plugged/youcompleteme/install.py --all \
