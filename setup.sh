#!/bin/bash

echo "Xcodeをインストールします..."
xcode-select --install < /dev/null

echo "シンボリックリンクを作成します..."
./link.sh

#------------------------------------------
# homebrew
#------------------------------------------
echo "homebrewをインストールします..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null

echo ".Brewfileで管理しているアプリケーションをインストールします..."
brew bundle --global

echo ".Brewfileで管理している不要なアプリケーションをアンインストールします..."
brew bundle cleanup --global --force

echo "iTerm2の設定を同期します..."
./iterm2/sync.sh

echo "Macの設定を同期します..."
./mac/sync.sh

# echo "プログラミング言語をインストールします..."

exec $SHELL -l
