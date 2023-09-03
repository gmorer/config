#!/usr/bin/env bash

rm -rf ${HOME}/.config/sway
ln -fs  ${PWD}/config/sway ${HOME}/.config/sway
rm -rf ${HOME}/.config/waybar
ln -fs  ${PWD}/config/waybar ${HOME}/.config/waybar
rm -rf ${HOME}/.config/rofi
ln -fs  ${PWD}/config/rofi ${HOME}/.config/rofi
rm -rf ${HOME}/.config/kanshi
ln -fs  ${PWD}/config/kanshi ${HOME}/.config/kanshi
rm -rf ${HOME}/.config/mako
ln -fs  ${PWD}/config/mako ${HOME}/.config/mako
rm -rf ${HOME}/.config/foot
ln -fs  ${PWD}/config/foot ${HOME}/.config/foot
mkdir -p ${HOME}/.config/systemd/user
cp -rf ${PWD}/sway.service ${HOME}/.config/systemd/user/sway.service
