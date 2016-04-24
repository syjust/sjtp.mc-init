#!/bin/bash
here="`dirname $0`"
file="$here/../doc/help.gitconfig.lst"

function display() {
	grep -E "^[[:blank:]]+${1}\.." $file
}

if [ ! -z "$1" ] ; then
	lst="`grep -E  "^[[:blank:]]+[^[:blank:]\.]*${1}[^\.]*\.." $file  | awk -F. '{print $1}' | uniq | sort`"
else
	lst="`grep -E  "^[[:blank:]]+[a-z]+\.." $file  | awk -F. '{print $1}' | uniq | sort`"
fi
size="`echo "$lst" | wc -w | awk '{print $1}'`"

if [ $size -gt 1 ] ; then
	echo "choose conf for display possible options"
	select conf in $lst ; do
		display $conf
		break
	done
else
	display $lst
fi
