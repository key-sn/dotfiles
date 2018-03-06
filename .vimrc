" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'altercation/vim-colors-solarized' 

" Note: :Unite -auto-preview colorschemeのコマンドが使える
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'


" Note: :NERDtreeのインストールと設定
NeoBundle 'scrooloose/nerdtree'
map <silent><C-e> :NERDTreeToggle<CR>

call neobundle#end()

" Note: :クリップボードの使用を許可する
set clipboard+=unnamed

syntax enable
set background=dark
colorscheme solarized

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
