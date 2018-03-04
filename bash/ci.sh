#!/bin/bash
citravis(){
if ! type "travis" > /dev/null 2>&1 ; then
  echo "Command Not Found:travis"
  return 0;
fi
if [ $# -ne 2 ]; then
  echo "Require [Username],[Reponame]"
else
  echo "travis encrypt -r $1/$2 \"<github_token>\""
  read -sp "GithubToken:" TOKEN
  #echo "<<$TOKEN>>"
  travis encrypt -r $1/$2 "$TOKEN"
fi
}
