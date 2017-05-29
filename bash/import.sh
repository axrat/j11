#!/bin/bash
helloworld(){
	echo "Hello,World!"
}
ks(){
	echo "Oops!"
}
shutdownlater(){
	sudo shutdown -h +300
}
rundir(){
	echo $(cd $(dirname $(readlink $0 || echo $0));pwd)
}
fromdir(){
	echo $(cd $(dirname $BASH_SOURCE); pwd)
}
#
download(){
	if [ ! -e ${1##*/} ]; then
		wget $1 --trust-server-names
	fi
}
#
dict(){
	grep $1 /j/bash/gene-utf8.txt -A 1 -wi --color
}
#
createsshkey(){
ssh-keygen -t rsa -C ""
}
createsshkeyauto(){
expect -c "
set timeout 10
spawn ssh-keygen -t rsa -C \"\"
expect -re \"Enter file in which to save the key\ (.\*\):\"
send \"\n\"
expect \"Enter passphrase \(empty for no passphrase\):\"
send \"\n\"
expect \"Enter same passphrase again:\"
send \"\n\"
expect eof exit 0
"
}
#
hideandseek(){
git filter-branch -f --index-filter '
git rm -rf --cached --ignore-unmatch * 
' HEAD
git filter-branch -f --index-filter '
touch .hidden | git add .hidden 
' HEAD
git reflog expire --expire=now --all
git gc --aggressive --prune=now
}
override(){
git checkout --orphan tmp
git commit -m "override"
git checkout -B master
git branch -d tmp
git push -f
}
seturl(){
git remote add     origin $1
git remote set-url origin $1
}
reset(){
rm -rf *
git init
git remote add     origin $1
git remote set-url origin $1
git fetch origin
git reset --hard origin/master
}
config(){
git config --local user.name onoie
git config --local user.email onoie3@gmail.com
}
shallowclone(){
git clone --depth 1 $1
git fetch --unshallow
}
changecommiter(){
USERNAME=onoie
USEREMAIL=onoie3@gmail.com
git filter-branch -f --env-filter "GIT_AUTHOR_NAME='${USERNAME}'; GIT_AUTHOR_EMAIL='${USEREMAIL}'; GIT_COMMITTER_NAME='${USERNAME}'; GIT_COMMITTER_EMAIL='${USEREMAIL}';" HEAD
}
commitcount(){
git shortlog -s -n
}
repositorymerge(){
if [ $# -ne 1 ]; then
  echo "require local target repository path" 1>&2
  echo "Ex) [~/whisky/repos/path]" 1>&2
  exit 1
fi
REPO_URL=$1
SUBDIR=$(basename $REPO_URL)
git fetch $REPO_URL/.git refs/heads/master:refs/heads/$SUBDIR
git filter-branch -f --tree-filter '
[ -d ${SUBDIR} ] || mkdir -p ${SUBDIR};
find . -mindepth 1 -maxdepth 1 ! -path ./${SUBDIR} | xargs -i{} mv {} ${SUBDIR}
' $SUBDIR
git merge --no-ff $SUBDIR
}
fastcommit(){
git commit --allow-empty -m "fast commit"
git push
}
creategithubgrasssvg(){
curl https://github.com/$1 | awk '/<svg.+class="js-calendar-graph-svg"/,/svg>/' | sed -e 's/<svg/<svg xmlns="http:\/\/www.w3.org\/2000\/svg"/' > $1.svg
}
browse(){
xdg-open $1
}


fixchmod(){
sudo chmod 755 ~
sudo chmod 755 ~/.ssh/../
sudo chmod 700 ~/.ssh -R
}

