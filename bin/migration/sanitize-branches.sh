#!/bin/bash
svn_prefix="git-svn"
branches="`git for-each-ref refs/remotes/$svn_prefix | cut -d / -f 4- | grep -v @`" 
for branch in $branches ; do
	echo "git branch \"$branch\" \"$svn_prefix/$branch\""
	git branch "$branch" "$svn_prefix/$branch"
	echo "git branch -r -d \"$svn_prefix/$branch\""
	git branch -r -d "$svn_prefix/$branch"
done

git branch --all -vv
