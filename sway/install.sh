#!/usr/bin/env bash

rm -rf ${HOME}/.config/sway
ln -fs  ${PWD}/config/sway ${HOME}/.config/sway
rm -rf ${HOME}/.config/waybar
ln -fs  ${PWD}/config/waybar ${HOME}/.config/waybar
rm -rf ${HOME}/.config/rofi
ln -fs  ${PWD}/config/rofi ${HOME}/.config/rofi
