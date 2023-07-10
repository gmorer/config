#!/usr/bin/env

ln -fs ${HOME}/Sync/metadata/pass ${HOME}/.password-store


# Register new key
# $> gpg-connect-agent "scd serialno" "learn --force" /bye
#
# Trust the key
# $> gpg --edit-key
# gpg> trust

#unset SSH_AGENT_PID
#if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#	gpgconf --launch gpg-agent
#	 GPG_TTY=$(tty)
#fi
