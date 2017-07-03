#!/bin/bash
killall(){
	if [ $# -ne 1 ]; then
		echo "Require [ProcessName]"
	else
		sudo killall -KILL $1
	fi
}
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
#reset(){
#rm -rf *
#git init
#git remote add     origin $1
#git remote set-url origin $1
#git fetch origin
#git reset --hard origin/master
#}
gitlocalconfig(){
git config --local user.name $1
git config --local user.email $2
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
find . -mindepth 1 -maxdepth 1 ! -path ./${SUBDIR} | xargs -i{} mv -f {} ${SUBDIR}
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
nginxandphpfpmfcgiwrap(){
  d_start(){
    sudo /etc/init.d/nginx   start
    sudo /etc/init.d/php-fpm start
    sudo /etc/init.d/fcgiwrap start
  }
  d_stop(){
    sudo /etc/init.d/nginx stop
    sudo /etc/init.d/php-fpm stop
    sudo /etc/init.d/fcgiwrap stop
  }
  case "$1" in
    start)
      d_start
      xdg-open http://localhost/
    ;;
    restart)
      d_stop
      sleep 2
      d_start
    ;;
    stop)
      d_stop
    ;;
    kill)
      sudo killall -KILL nginx
      sudo killall -KILL php-fpm
      sudo killall -KILL fcgiwrap
    ;;
  esac
}
fixchmod(){
sudo chmod 755 ~
sudo chmod 755 ~/.ssh/../
sudo chmod 700 ~/.ssh -R
}

devcopy(){
sudo df
echo "Ex) dd if=/dev/sr0 of=/root/dev.iso"
echo "if path:"
read DDIF
echo "of path:"
read DDOF
sudo dd if=$DDIF of=$DDOF
}
cases(){
mkdir -p case1
mkdir -p case2
mkdir -p case3
touch case1/.gitkeep
touch case2/.gitkeep
touch case3/.gitkeep
}
launch_maya(){
	sudo /usr/autodesk/maya2016/bin/maya
}
launch_unity(){
	LD_PRELOAD=/lib/x86_64-linux-gnu/libresolv.so.2 /opt/Unity/Editor/Unity
}
download_bitbucket(){
  if [ $# -ne 3 ]; then
    echo "Require bitbucket [username],[repouser],[reponame]"
  else
    wget --user=$1 --ask-password https://bitbucket.org/$2/$3/get/master.zip
  fi
}
getZipRootDirectoryName(){
  unzip -qql $1 | head -n1 | tr -s ' ' | cut -d' ' -f5- | rev | cut -c 2- | rev
}
togif(){
  if [ $# -ne 1 ]; then
    echo "Require [Filename]"
  else
    ffmpeg -i "$1" -an -r 24 "$(pwd)/${$(basename $1)%.*}.gif"
  fi
}
base64 () {
  #usage cat image.gif | base64 > img.css
  w=''
  case "${1:-}" in
    --wrap=*) printf '%s\n' "$1" | grep -q '^--wrap=[0-9]\{1,\}$' && {
                w=${1#--wrap=}
              }
              ;;
  esac
  case "$w" in '') w=76;; esac
  od -A n -t x1 -v                                                         |
  awk 'BEGIN{OFS=""; ORS="";                                               #
             x2o["0"]="0000"; x2o["1"]="0001"; x2o["2"]="0010";            #
             x2o["3"]="0011"; x2o["4"]="0100"; x2o["5"]="0101";            #
             x2o["6"]="0110"; x2o["7"]="0111"; x2o["8"]="1000";            #
             x2o["9"]="1001"; x2o["a"]="1010"; x2o["b"]="1011";            #
             x2o["c"]="1100"; x2o["d"]="1101"; x2o["e"]="1110";            #
             x2o["f"]="1111";                                              #
             x2o["A"]="1010"; x2o["B"]="1011"; x2o["C"]="1100";            #
             x2o["D"]="1101"; x2o["E"]="1110"; x2o["F"]="1111";         }  #
       {     l=length($0);                                                 #
             for(i=1;i<=l;i++){print x2o[substr($0,i,1)];}                 #
             printf("\n");                                              }' |
  awk 'BEGIN{s="";                                                      }  #
       {     buf=buf $0;                                                   #
             l=length(buf);                                                #
             if(l<6){next;}                                                #
             u=int(l/6)*6;                                                 #
             for(p=1;p<u;p+=6){print substr(buf,p,6);}                     #
             buf=substr(buf,p);                                         }  #
       END  {if(length(buf)>0){print substr(buf "00000",1,6);}          }' |
  awk 'BEGIN{ORS=""; w='$w';                                               #
             o2b6["000000"]="A"; o2b6["000001"]="B"; o2b6["000010"]="C";   #
             o2b6["000011"]="D"; o2b6["000100"]="E"; o2b6["000101"]="F";   #
             o2b6["000110"]="G"; o2b6["000111"]="H"; o2b6["001000"]="I";   #
             o2b6["001001"]="J"; o2b6["001010"]="K"; o2b6["001011"]="L";   #
             o2b6["001100"]="M"; o2b6["001101"]="N"; o2b6["001110"]="O";   #
             o2b6["001111"]="P"; o2b6["010000"]="Q"; o2b6["010001"]="R";   #
             o2b6["010010"]="S"; o2b6["010011"]="T"; o2b6["010100"]="U";   #
             o2b6["010101"]="V"; o2b6["010110"]="W"; o2b6["010111"]="X";   #
             o2b6["011000"]="Y"; o2b6["011001"]="Z"; o2b6["011010"]="a";   #
             o2b6["011011"]="b"; o2b6["011100"]="c"; o2b6["011101"]="d";   #
             o2b6["011110"]="e"; o2b6["011111"]="f"; o2b6["100000"]="g";   #
             o2b6["100001"]="h"; o2b6["100010"]="i"; o2b6["100011"]="j";   #
             o2b6["100100"]="k"; o2b6["100101"]="l"; o2b6["100110"]="m";   #
             o2b6["100111"]="n"; o2b6["101000"]="o"; o2b6["101001"]="p";   #
             o2b6["101010"]="q"; o2b6["101011"]="r"; o2b6["101100"]="s";   #
             o2b6["101101"]="t"; o2b6["101110"]="u"; o2b6["101111"]="v";   #
             o2b6["110000"]="w"; o2b6["110001"]="x"; o2b6["110010"]="y";   #
             o2b6["110011"]="z"; o2b6["110100"]="0"; o2b6["110101"]="1";   #
             o2b6["110110"]="2"; o2b6["110111"]="3"; o2b6["111000"]="4";   #
             o2b6["111001"]="5"; o2b6["111010"]="6"; o2b6["111011"]="7";   #
             o2b6["111100"]="8"; o2b6["111101"]="9"; o2b6["111110"]="+";   #
             o2b6["111111"]="/";                                           #
             if (getline) {print o2b6[$0];n=1;}                         }  #
       n==w {printf("\n")  ; n=0;                                       }  #
       {     print o2b6[$0]; n++;                                       }  #
       END  {if(NR>0){printf("%s\n",substr("===",1,(4-(NR%4))%4));}     }'
}
portcheck(){
  if [ $# -ne 1 ]; then
    echo "Require [PortNumber]"
  else
    sudo netstat -apnt4 | grep $1	
  fi
}

compress(){
  tar cfvz $1.tar.gz $1/
}
extract(){
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
	  *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
	  *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)
        echo "Unable to extract '$1'"
      ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
hr(){
  CHAR=${1:-"-"}
  for i in `seq 1 $COLUMNS`
  do
    printf "${CHAR}";
  done
}
declare -a jetbrains=("IdeaProjects" "PhpstormProjects" "CLionProjects" "PycharmProjects" "RubymineProjects" "WebstormProjects" "GoglandProjects" "RiderProjects")
createJetBrainsDirectory(){
  for ((i = 0; i < ${#jetbrains[@]}; i++)) {
    echo "mkdir -p ${jetbrains[i]}"
  }
}
