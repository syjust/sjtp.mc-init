#!/bin/bash

here="`dirname $0`"
. $here/commons.inc.sh $0

# preparer : checkouting svn repos from assembla
title "checkouting svn repos from assembla" \
	&& svn co \
		--username=syjust \
		--password=sjtp-MC-2016 \
		http://svn.assembla.com/svn/sjtp.mc \
		svn_wc
cont $?

# preparer : extrating authors
title "preparer : extrating authors" \
	&& cd svn_wc \
	&& ../sjtp.mc-init/bin/migration/extract-authors.sh > ../users.txt \
	&& cd ../ \
	&& vi users.txt
cont $?

# convertir II : convert svn repo with git-svn
title "convertir II : convert svn repo with git-svn" \
	&& git svn clone --stdlayout \
		--prefix=git-svn/ \
		--authors-file=users.txt \
		http://svn.assembla.com/svn/sjtp.mc \
		git_svn_wc \
	&& cd git_svn_wc \
	&& git branch --all -vv  \
	&& cd ../
cont $?

# convertir III : show logs after git-svn clone
title "convertir III : show logs after git-svn clone" \
	&& cd git_svn_wc \
	&& git log \
	&& cd ../
cont $?

# syncrhoniser
title "syncrhoniser" \
	&& echo "DO SOME COMMITS IN SVN then try to fetch them in GIT REPO"
cont $?

