#!/bin/bash

PARAMS=('-m 6 -q 70 -mt -af -progress')

#THREAD=$(cat /proc/cpuinfo  | grep processor | wc -l)
THREAD=8


if [ $# -ne 0 ]; then
	PARAMS=$@;
fi

cd $(pwd)

shopt -s nullglob nocaseglob extglob

# Create tmp pipe to wait for process
mkfifo tmp

COUNTER=0
for FILE in *.@(jpg|jpeg|tif|tiff|png); do 
    if [ $COUNTER -lt $THREAD ]; then
	let $[COUNTER++];
	echo "Starting " $COUNTER
	{ cwebp $PARAMS "$FILE" -o "${FILE%.*}".webp ; echo "OK" > tmp; } &
    else 
	read < tmp
	let $[COUNTER++];
	echo "Starting " $COUNTER
	{ cwebp $PARAMS "$FILE" -o "${FILE%.*}".webp ; echo "OK" > tmp; } &
    fi
done

cat tmp > /dev/null

rm tmp
