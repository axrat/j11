#!/bin/bash

alias s='git status'
GIT_USER_NAME=onoie
GIT_USER_EMAIL=onoie3@gmail.com
ssh-github(){
  ssh -T git@github.com
}
ssh-bitbucket(){
  ssh -T git@bitbucket.org
}
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
git push -f --set-upstream origin master
}
seturl(){
git remote add     origin $1
git remote set-url origin $1
}
#reset(){
#rm -rf *
#git init
#git remote add     origin $1
#git remote set-url origin $1
#git fetch origin
#git reset --hard origin/master
#}
shallowclone(){
git clone --depth 1 $1
git fetch --unshallow
}
changecommiter(){
USERNAME=onoie
USEREMAIL=onoie3@gmail.com
git filter-branch -f --env-filter "GIT_AUTHOR_NAME='${USERNAME}'; GIT_AUTHOR_EMAIL='${USEREMAIL}'; GIT_COMMITTER_NAME='${USERNAME}'; GIT_COMMITTER_EMAIL='${USEREMAIL}';" HEAD
}
repositorymerge(){
if [ $# -ne 1 ]; then
  echo "require local target repository path" 1>&2
  echo "Ex) [~/repos/repo]" 1>&2
  exit 1
fi
REPO_URL=$1
SUBDIR=$(basename $REPO_URL)
git fetch $REPO_URL/.git refs/heads/master:refs/heads/$SUBDIR
git filter-branch -f --tree-filter '
[ -d ${SUBDIR} ] || mkdir -p ${SUBDIR};
find . -mindepth 1 -maxdepth 1 ! -path ./${SUBDIR} | xargs -i{} mv -f {} ${SUBDIR}
' $SUBDIR
git merge --allow-unrelated-histories --no-ff $SUBDIR
}
changecommitmessage(){
  MSG=${@:-"### private commit message ###"}
  git filter-branch --msg-filter "echo '${MSG}';" -f
}
creategithubgrasssvg(){
curl https://github.com/$1 | awk '/<svg.+class="js-calendar-graph-svg"/,/svg>/' | sed -e 's/<svg/<svg xmlns="http:\/\/www.w3.org\/2000\/svg"/' > $1.svg
}
clone(){
  if [ $# -ne 5 ]; then
    echo "Require [RepositoryHost]:[Username]/[RepositoryName].git"
    echo "git local [GitUsername] [GitEmail]"
  else
    git clone git@$1:$2/$3.git
    cd $3
    git config --local user.name "$4"
    git config --local user.email "$5"
  fi
}
fclone(){
  if [ $# -ne 3 ]; then
    echo "Require[domain],[repouser],[reponame]"
  else
    git clone git@$1:$2/$3.git
  fi
}
fconfig(){
  git config --local user.name ${1:-$GIT_USER_NAME}
  git config --local user.email ${2:-$GIT_USER_EMAIL}
}
fcommit(){
  MSG=${@:-"fast commit"}
  git commit --allow-empty -m "$MSG"
  git push --set-upstream origin master
}
fadd(){
  git add .
}
fcount(){
  git shortlog -s -n
}
fpush(){
  git push --set-upstream origin master
}
fpull(){
  git pull origin master --depth=1
}
freset(){
  git reset --soft HEAD^
}
fresethard(){
  git reset --hard origin/master
}
fremote(){
  if [ $# -ne 3 ]; then
    echo "Require[domain],[repouser],[reponame]"
  else
    git remote add origin git@$1:$2/$3.git
  fi
}
getLastCommitMessage(){
  if [ $# -ne 3 ]; then
    echo "require [host],[user],[repository]"
    exit 1
  fi
  HOST=$1
  USER=$2
  REPO=$3
  curl https://$HOST/$USER/$REPO \
   | sed -n -e "/<div class=\"commit-tease js-details-container Details\">/,/<\/div>/p" \
   | grep title \
   | awk '{print substr($0, index($0, ">"))}' \
   | awk '{sub("<.*", "");print $0;}' \
   | cut -c 2-
}

gitrmremotebranch(){
  if [ $# -ne 1 ]; then
    echo "Require [branch]"
  else
    git push --delete origin $1
  fi
}

getGithubPublicRepositoryViaAPI(){
curl https://api.github.com/users/onoie/repos
}
getGithubPrivateRepositoryViaAPI(){
ACCESS_TOKEN=$1
ORG=$2
curl -u :${ACCESS_TOKEN} https://api.github.com/orgs/$ORG{}/repos
curl -H 'Authorization: token ${ACCESS_TOKEN}' https://api.github.com/orgs/$ORG/repos
curl 'https://api.github.com/orgs/${ORG}/repos?access_token=${ACCESS_TOKEN}'
}
gitcreateremotebranch(){
  if [ $# -ne 1 ]; then
    echo "Require [branch]"
  else
    git branch $1
	git checkout $1
	git branch --all
	git push origin master:$1
  fi
}
gitdeleteremotebranch(){
  if [ $# -ne 1 ]; then
    echo "Require [branch]"
  else
    git branch -d $1
	git push --delete origin $1
  fi
}
gitskip(){
  if [ $# -ne 1 ]; then
    echo "Require [filepath]"
  else
    git update-index --skip-worktree $1
  fi
}
gitskiprevert(){
  if [ $# -ne 1 ]; then
    echo "Require [filepath]"
  else
    git update-index --no-skip-worktree $1
  fi
}
gitskipcheck(){
  git ls-files -v | grep ^S
}



