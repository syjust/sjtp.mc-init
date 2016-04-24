#!/bin/bash

here="`dirname $0`"
. $here/commons.inc.sh $0

# checkout from assembla
title "checkout from assembla" \
	&& svn co http://subversion.assembla.com/svn/sjtp.mc svn_wc
cont $?

