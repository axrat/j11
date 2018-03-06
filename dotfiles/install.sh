#!/bin/bash
ln -s /j11/dotfiles/gitconfig ~/.gitconfig
ln -s /j11/dotfiles/gitignore_global ~/.gitignore_global
ln -s /j11/dotfiles/devilspie ~/.devilspie
ln -s /j11/dotfiles/nanorc ~/.nanorc
ln -s /j11/dotfiles/vimrc ~/.vimrc
ln -s /j11/dotfiles/vim ~/.vim
ln -s /j11/dotfiles/dein.toml ~/.dein.toml
ln -s /j11/dotfiles/dein_lazy.toml ~/.dein_lazy.toml
ln -s /j11/dotfiles/emacs ~/.emacs
ln -s /j11/dotfiles/bash_completion ~/.bash_completion

#dein
DEIN_PATH=~/.vim/dein/repos/github.com/Shougo/dein.vim
if [ -d $DEIN_PATH ]; then
  echo "found $DEIN_PATH"
else
  DOWNLOAD=installer.sh
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $DOWNLOAD
  chmod +x $DOWNLOAD
  sh ./$DOWNLOAD ~/.vim/dein
  rm $DOWNLOAD
fi

echo "ADD .bashrc"
hr(){
  CHAR=${1:-"-"}
  for i in `seq 1 $(tput cols)`
  do
    printf "${CHAR}";
  done
}
hr
cat << 'EOF'
export BIN="~/bin"
export PATH=$PATH:$BIN
[[ -f $BIN/x ]] && . $BIN/x
EOF
hr


