#!/bin/bash

here="`dirname $0`"
. $here/commons.inc.sh $0

# first tag
title "first tag" \
	&& git tag v1.0 -m "First Release"
cont $?

# first branch (testing)
title "first branch (testing)" \
	&& git branch testing \
	&& git checkout testing
cont $?

# modif on branch testing
title "modif on branch testing" \
	&& touch file-2.txt \
	&& git add file-2.txt \
	&& git commit -m "file-2 added"
cont $?

# return on master
title "return on master" \
	&& git checkout master \
	&& echo "modif" >> file.txt \
	&& git commit -am "file new mod"
cont $?

# reset master and rename branch to iss53
title "reset master and rename branch to iss53" \
	&& git reset HEAD^ \
	&& git branch -m testing iss53
cont $?

# creating hotfix branch
title "creating hotfix branch" \
	&& git checkout -b hotfix \
	&& sed -i 's/foo/bar/' file.txt \
	&& git commit -am "mail > bar on hotfix"
cont $?

# merging hotfix on master
title "merging hotfix on master" \
	&& git checkout master \
	&& git merge hotfix
cont $?

# show logs after merge
title "show logs after merge" \
	&& git lg --all
cont $?

# new modif on branch iss53
title "new modif on branch iss53" \
	&& git checkout iss53 \
	&& sed -i 's/foo/titi/' file.txt \
	&& git commit -am "mail > titi on iss53"
cont $?

# return on mater and prepare merge
title "return on mater and prepare merge" \
	&& git checkout master \
	&& git lg --all
cont $?

# merging iss53 on master (with conflict)
title "merging iss53 on master (with conflict)" \
	&& git merge iss53
git status --short

# use mergetool to resolve conflict after merge
title "use mergetool to resolve conflict and commit" \
	&& git mergetool \
	&& git status --short \
	&& git lg
cont $?

# reseting master to c4
title "reseting master to c4" \
	&& git reset --hard HEAD^ \
	&& git lg --all
cont $?

# rebasing iss53 on master
title "rebasing iss53 on master" \
	&& git checkout iss53 \
	&& git rebase master

# use mergetool to resolve conflict after rebase
title "use mergetool to resolve conflict after rebase" \
	&& git mergetool
cont $?

# continue rebasing after conflict
title "continue rebasing after conflict" \
	&& git rebase --continue \
	&& git lg --all
cont $?

# update master on iss53 after rebasing
title "update master on iss53 after rebasing" \
	&& git checkout master \
	&& git merge iss53 \
	&& git lg --all
cont $?
