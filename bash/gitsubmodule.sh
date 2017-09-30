
gitsubmoduleadd(){
  if [ $# -ne 3 ]; then
    echo "Require [RepoHost],[RepoUser],[RepoName]"
  else
	git submodule add https://$1/$2/$3.git $3
  fi
}
gitsubmoduleinit(){
  git submodule update --init --recursive
}
gitsubmoduleupdate(){
  git submodule foreach 'git pull origin master --allow-unrelated-histories'
}

