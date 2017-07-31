"~/.vimrc

" Require
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,latin1
set fileformats=unix,dos,mac
scriptencoding utf-8
syntax enable
colorscheme torte

"Setting
set ruler " 右下に表示される行・列の番号を表示
set autoindent " 自動インデントを有効にする
set tabstop=4 " タブを表示する時の幅
set shiftwidth=4 " 自動で挿入されるインデントの幅
set softtabstop=4 " タブ入力時の幅を4に設定
set showmatch " 閉じ括弧入力時に対応する括弧の強調
set matchtime=4 " showmatch設定の表示秒数(0.1秒単位)
set incsearch " インクリメンタルサーチを行う(検索文字入力中から検索)
set ignorecase " 文字列検索で大文字小文字を区別しない
set hlsearch " 文字列検索でマッチするものをハイライト表示する
set smartcase " 検索文字に大文字が含まれる場合にignorecaseをOFFにする(大文字小文字を区別する)
set wildmenu " コマンドラインにおける補完候補の表示
set t_kD=^? " Deleteキーを有効にする
set backspace=indent,eol,start " バックスペースキーの動作を普通のテキストエディタと同じようにする
set title " 編集中のファイル名を表示
set wrap " ウィンドウの幅より長い行は折り返して表示
set clipboard=unnamedplus,autoselect
" 見た目によるカーソル移動をする(1行が複数行に渡って表示されている時に表示上の行ごとに上下移動させる)
nnoremap j gj
nnoremap k gk

"DeinStart
"let s:dein_dir = expand('~/.vim/dein')
"let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"if &compatible
"  set nocompatible
"endif
"if !isdirectory(s:dein_repo_dir)
"  execute '!git clone git@github.com:Shougo/dein.vim.git' 
"s:dein_repo_dir
"endif
"execute 'set runtimepath^=' . s:dein_repo_dir

"if dein#load_state(s:dein_dir)
"  call dein#begin(s:dein_dir)

"  call dein#add('Shougo/dein.vim')
"  call dein#add('Shougo/unite.vim')
"  call dein#add('itchyny/lightline.vim')
"  call dein#add('thinca/vim-quickrun')
"  call dein#add('plasticboy/vim-markdown')
"  call dein#add('kannokanno/previm')
"  call dein#add('tyru/open-browser.vim')
"  call dein#add('scrooloose/syntastic')
"  call dein#add('junegunn/vim-easy-align')
"  call dein#add('mattn/emmet-vim')
"  call dein#add('onoie/migawari')

"  let s:toml = '~/.dein.toml'
"  let s:lazy_toml = '~/.dein_lazy.toml'
"  call dein#load_toml(s:toml,      {'lazy': 0})
"  call dein#load_toml(s:lazy_toml, {'lazy': 1})

"  call dein#end()
"  call dein#save_state()
"endif

"if dein#check_install()
"  call dein#install()
"endif
"filetype plugin indent on
"DeinEnd

"for lightline
"set laststatus=2
"let g:lightline = {
"    \ 'colorscheme' : 'wombat'
"    \ }

"for easy-align
"xmap ga <Plug>(EasyAlign)
"nmap ga <Plug>(EasyAlign)
