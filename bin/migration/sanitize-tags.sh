#!/bin/bash
svn_prefix="git-svn"
tags="`git for-each-ref refs/remotes/$svn_prefix/tags | cut -d / -f 5- | grep -v @`" 
for tag in $tags ; do
	echo "git tag \"$tag\" \"$svn_prefix/tags/$tag\""
	git tag "$tag" "$svn_prefix/tags/$tag"
	echo "git branch -r -d \"$svn_prefix/tags/$tag\""
	git branch -r -d "$svn_prefix/tags/$tag"
done

git branch --all -vv
