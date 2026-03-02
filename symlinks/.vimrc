" クリップボードの使用を許可する
set clipboard+=unnamed

" 行番号を表示
set number

" InsertモードでTab入力時にタブ文字→半角スペースへ変更
set expandtab

" 検索結果のハイライト
set hlsearch

" 検索結果で大文字小文字を区別しない
set ignorecase
" 検索時に大文字がある場合に大文字小文字を区別するようにする
set smartcase

" インクリメンタルサーチ
set incsearch

" ステータスバー(ファイル名等の情報)の表示
set laststatus=2

" シンタックスハイライトを有効か
syntax enable

" 改行時に同じインデントにしてくれる
set autoindent

" Vimが暗い背景によく合う色を使おうとする
set background=dark

" デフォルト文字コード
set encoding=utf-8

" 文字コード推定に使う文字コードリスト
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

" 改行コードの自動認識
set fileformats=unix,dos,mac

" ファイルタイプの自動検出及びファイルタイプ用のプラグインとインデント設定を自動読込
filetype plugin indent on

