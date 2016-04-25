#!/bin/bash
TITLE=all
SKIP=0
function quit() {
	echo "$1"
	exit 1
}
function cont() {
	local mess=""
	local code=0
	if [ $SKIP -ne 1 ] ; then
		while [ ! -z $1 ] ; do
			if [[ $1 =~ ^[0-9]+$ ]] ; then
				code=$1
			else
				mess=$1
			fi
			shift
		done
		if [ $code -gt 0 -a $SKIP -eq 0 ] ; then
			quit "error found here ($mess)"
		else
			if [ -z "$mess" ] ; then
				echo -n "press enter to continue..."
			else
				echo -n "press enter to continue with '$1'..."
			fi
			[ "x$TITLE" == "xyes-all" ] || read
		fi
	fi
	return $code
}

function title() {
	local ret=0
	echo
	echo "# --------------------"
	if [ "x$TITLE" != "xnone" ] && [ "x$TITLE" == "xall" -o "x$TITLE" == "x$1" -o "x$TITLE" == "xyes-all" ] ; then
		echo "# $1"
		[ "x$TITLE" == "xyes-all" ] || TITLE="all"
		SKIP=0
	else
		ret=1
		SKIP=1
		echo "# skipping ... $1"
	fi
	echo "# --------------------"
	return $ret
}

if [ ! -z "$1" ] ; then
	if [ -e "$1" ] ; then
		echo "From Where to Start ?"
		ifs=$IFS
		IFS=$'\n'
		select TITLE in all ` cat <(grep -E "^title" $1 | awk -F\" '{print $2}')` yes-all none ; do
			break
		done
		IFS=$ifs
	fi
fi
