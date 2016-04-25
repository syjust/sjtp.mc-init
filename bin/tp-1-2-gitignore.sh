#!/bin/bash

here="`dirname $0`"
. $here/commons.inc.sh $0

# creating ignore branch
title "creating ignore branch" \
	&& git checkout -b ignore-branch
cont $?

# generating keepme files & commit
title "generating keepme files & commit" \
	&& if [ ! -d "etc" ] ; then
		for i in etc usr/{local/bin,bin,sbin} ; do
			mkdir -p $i
			touch $i/.keepme
			git add $i/.keepme
		done
		git commit -m "keepme new dirs"
	fi
cont $?

# generating system files
title "generating system files" \
	&& touch file.{tmp,log} \
	&& touch etc/file.{cnf,tmp,log} \
	&& touch usr/bin/file.{tmp,log} \
	&& touch usr/local/bin/file.{tmp,log} \
	&& touch usr/sbin/file.{tmp,log}
cont $?

# status after adding files
title "status after adding files" \
	&& git status --short --branch
cont $?

# ignore x.tmp and /file.x
title "ignore tmp and /file" \
	&& echo "*.tmp" > .gitignore \
	&& echo "/file.*" >> .gitignore \
	&& echo "modif" >> file.txt \
	&& git status --short --branch
cont $?

# ignoring etc/x.log
title "ignoring etc/*.log" \
	&& echo "etc/*.log" >> .gitignore \
	&& git status --short --branch
echo
cont $?

# ignoring xx/bin
title "ignoring xx/bin" \
	&& echo "**/bin" >> .gitignore \
	&& git status --short --branch
cont $?

# commiting everything
title "commiting everything" \
	&& git add etc/file.cnf usr/sbin/file.log .gitignore \
	&& git commit -am "ignoring some files"
cont $?

# checkout master and remove ignore-branch
title "checkout master and remove ignore-branch" \
	&& git checkout master \
	&& git branch -D ignore-branch
cont $?
