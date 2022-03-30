#!/usr/bin/env bash

rm -rf ${HOME}/.config/sway
ln -fs  ${PWD}/config/sway ${HOME}/.config/sway
rm -rf ${HOME}/.config/waybar
ln -fs  ${PWD}/config/waybar ${HOME}/.config/waybar
rm -rf ${HOME}/.config/wofi
ln -fs  ${PWD}/config/wofi ${HOME}/.config/wofi
rm -rf ${HOME}/.config/kanshi
ln -fs  ${PWD}/config/kanshi ${HOME}/.config/kanshi
rm -rf ${HOME}/.config/mako
ln -fs  ${PWD}/config/mako ${HOME}/.config/mako
