#!/usr/bin/env bash

echo "Depend on go rust clang, nice nerd fonts..."

mkdir -p ${HOME}/bin \
&& curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o ${HOME}/bin/nvim \
&& chmod +x ${HOME}/bin/nvim \
&& sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
&& mkdir -p ${HOME}/.config/nvim \
&& mkdir -p ${HOME}/.local/share/nvim \
&& ln -fs  ${PWD}/resources/init.vim ${HOME}/.config/nvim/init.vim \
&& nvim --headless +PlugInstall +qall \
&& ${HOME}/.local/share/nvim/plugged/youcompleteme/install.py --all \
