#!/bin/bash

here="`dirname $0`"
. $here/commons.inc.sh $0

# slide 1
title "slide 1" \
	&& git init
cont $?

# first status
title "first status" \
	&& git status \
	&& echo "first file" > file.txt \
	&& echo "second file" > f2.txt
cont $?

# second status
title "second status" \
	&& git status \
	&& git add *.txt
cont $?

# third status
title "third status" \
	&& git status
cont $?

# fourth status
title "fourth status" \
	&& git status --short \
	&& git commit -m "first commit"
cont $?

# last status
title "last status" \
	&& git status \
	&& git status --short
cont $?

# slide 2
title "slide 2" \
	&& echo "foo@mc.com" >> file.txt \
	&& git add file.txt \
	&& git commit -m "email here" \
	&& git rm f2.txt \
	&& git commit -m "remove f2"
cont $?
