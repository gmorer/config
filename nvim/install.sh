#!/usr/bin/env bash

echo "Depend on go rust clang, nice nerd fonts..."

FILE_DIR=${HOME}/config/nvim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
&& mkdir -p ${HOME}/.config/nvim \
&& mkdir -p ${HOME}/.config/ctags \
&& mkdir -p ${HOME}/.local/share/nvim \
&& ln -fs  ${FILE_DIR}/resources/init.vim ${HOME}/.config/nvim/init.vim \
&& ln -fs  ${FILE_DIR}/resources/ctagsrc ${HOME}/.config/ctags/ctagsrc \
&& nvim --headless +PlugInstall +qall \
&& ${HOME}/.local/share/nvim/plugged/youcompleteme/install.py --all \
