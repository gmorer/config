#!/usr/bin/env

ln -fs ${HOME}/Sync/metadata/pass ${HOME}/.password-store

#unset SSH_AGENT_PID
#if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#	gpgconf --launch gpg-agent
#	 GPG_TTY=$(tty)
#fi
