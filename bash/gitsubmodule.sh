gitsubmoduleinit(){
  git submodule update --init --recursive
}
gitsubmoduleupdate(){
  git submodule foreach 'git pull origin master --allow-unrelated-histories'
}

