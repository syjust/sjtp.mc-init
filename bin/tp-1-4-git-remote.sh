#!/bin/bash

here="`dirname $0`"
. $here/commons.inc.sh $0

# remote add in git_wc
title "remote add in git_wc" \
	&& git remote add origin https://github.com/syjust/sjtp.mc-remote \
	&& git branch --all -vv
cont $?

# fetch origin
title "fetch origin" \
	&& git fetch origin master \
	&& git branch --all -vv
cont $?

# fetch other branches
title "fetch other branches" \
	&& git fetch origin syl john jane \
	&& git branch --all -vv
cont $?
