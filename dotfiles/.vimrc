"~/.vimrc

" Require
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,latin1
set fileformats=unix,dos,mac
scriptencoding utf-8
syntax enable
colorscheme torte

set list
set listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%
"Setting
set ruler " 右下に表示される行・列の番号を表示
set autoindent " 自動インデントを有効にする
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0
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


"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/onoie/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/onoie/.vim/dein')
  call dein#begin('/home/onoie/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/onoie/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/unite.vim')
  call dein#add('itchyny/lightline.vim')
  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------


"for lightline
set laststatus=2
let g:lightline = {
    \ 'colorscheme' : 'wombat'
    \ }

"for easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"Helper
function! s:tab2Space()
  execut 'set expandtab'
  execut 'retab!'
endfunction
command! Tab2Space :call s:tab2Space()
function! s:space2Tab()
  execut 'set noexpandtab'
  execut 'retab!'
endfunction
command! Space2Tab :call s:space2Tab()

"Note
"reload function source %
"selectall function ggv<shift+g>
