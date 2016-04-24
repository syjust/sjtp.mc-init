#!/bin/bash
if [ "x$1" == "x-r" ] ; then
	echo "reseting HEAD & files & dirs"
	git reset --hard HEAD^
	rm -rf .gitignore file.{tmp,log} etc usr var
	read
	reset=1
else
	reset=0
fi

if [ ! -d "etc" ] ; then
	for i in etc usr/{local/bin,bin,sbin} ; do
		mkdir -p $i
		touch $i/.keepme
		git add $i/.keepme
	done
	git ci -m "keepme new dirs"
fi

touch file.{tmp,log}
touch etc/file.{cnf,tmp,log}
touch usr/bin/file.{tmp,log}
touch usr/local/bin/file.{tmp,log}
touch usr/sbin/file.{tmp,log}

echo
echo "without .gitignore"
git status --short
#git ls-files -o --exclude-standard
read

echo "*.tmp" > .gitignore
echo "/file.*" >> .gitignore
echo "modif" >> file.txt
echo
echo "ignoring *.tmp & /file.*"
git status --short
#git ls-files -o --exclude-standard
read

echo "etc/*.log" >> .gitignore
echo
echo "ignoring etc/*.log"
git status --short
#git ls-files -o --exclude-standard
read

echo "**/bin" >> .gitignore
echo
echo "ignoring **/bin"
git status --short
#git ls-files -o --exclude-standard
read
