#!/usr/bin/env bash

NAME="script.sh"

ARGC=$#
ARGV=$@

LOG_FILE="./logs.err"
rm -rf ${LOG_FILE}

MODULES=`ls -1 | grep -v ${NAME}`
COMMANDS=`ls ${MODULES} ~ -1 | grep -v : | grep -v "/"| grep -E \*.sh$ | sed 's/.sh$//' | sort | uniq`

RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[0m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

function execute {
	SCRIPT="${2}.sh"
	echo -n "Executing ${2} on ${1}	...	"	
	LOG=$(cd ${1} ; bash ${SCRIPT} 2>&1)
	if [[ $? -eq 0 ]];then
		echo -e ${BOLD}${GREEN}OK${WHITE}${NORMAL}
	else
		echo "[[ ----- ${1}/${SCRIPT} ----- ]]" >> ${LOG_FILE}
		echo ${LOG} >> ${LOG_FILE}
		echo -e ${BOLD}${RED}KO${WHITE}${NORMAL}
	fi
}

function contains {
	[[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]] && echo 'yes' || echo 'no'
}

function usage {
	echo "Usage: ${0} [CMD] [MODULE]..."
	echo ""
	echo "${BOLD}Commands:${NORMAL}"
	echo ${COMMANDS}
	echo ""
	echo "${BOLD}Modules:${NORMAL}"
	for m in ${MODULES}; do
		echo -n "${m}	"
		DESC=`cat ${m}/description.txt 2>&-`
		if [[ $? -eq 0 ]]; then
			echo ${DESC}
		else
			echo "No description"
		fi
	done
}

if [[ ARGC -eq 0 || $1 == "--help" || $1 == "-h" ]]; then
	usage
	exit
fi

if [[ $(contains "$COMMANDS" "$1") == "no" ]]; then
	echo "${0}: invalid command ${1}
Try '${0} --help' for more information." >&2
	exit 1
fi

COMMAND="$1"

if [[ -z $2 ]]; then
	for MODULE in ${MODULES} ; do
	if [[ -f "${MODULE}/${COMMAND}.sh" ]]; then
		execute "${MODULE}" "${COMMAND}"
	fi
	done
else
	MODULE="$2"
	if [[ -f "${MODULE}/${COMMAND}.sh" ]]; then
		execute "${MODULE}" "${COMMAND}"
	else
		echo "The command ${COMMAND} do no exist for the module ${MODULE}" >&2
	fi
fi

if [[ -f ${LOG_FILE} ]]; then
	ERR_NUM=`cat ${LOG_FILE} | grep "\[\[ ----- " | wc -l`
	echo "${BOLD}${ERR_NUM} error(s)${NORMAL} found, more information in ${BOLD}${LOG_FILE}${NORMAL}" >&2
fi
