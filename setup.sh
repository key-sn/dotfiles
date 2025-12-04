#!/bin/bash

set -e  # エラーで停止

DOTFILES_DIR="${HOME}/dotfiles"
DOTFILES_REPO="https://github.com/key-sn/dotfiles.git"

echo "==> dotfilesリポジトリをセットアップ中..."
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "dotfilesディレクトリは既に存在します。更新します..."
    cd "$DOTFILES_DIR" && git pull
fi

cd "$DOTFILES_DIR"

# Xcodeコマンドラインツールのインストール
if ! xcode-select -p &> /dev/null; then
  echo "==> Xcodeコマンドラインツールをインストール中..."
  xcode-select --install
  # インストール完了を待つ
  until xcode-select -p &> /dev/null; do
    sleep 5
  done
else
    echo "Xcodeコマンドラインツールは既にインストール済みです"
fi

# シンボリックリンクの作成
echo "==> シンボリックリンクを作成中..."

# ホームディレクトリにシンボリックリンクを設定
for dotfile in "${DOTFILES_DIR}"/symlinks/.??* ; do
  # 除外するドットファイル
  [[ "$dotfile" == "${DOTFILES_DIR}/.DS_Store" ]] && continue
  
  ln -sfnv "$dotfile" "$HOME"
done

# starship.tomlのシンボリックリンクを設定
mkdir -p "$HOME/.config"
ln -sfv "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

#------------------------------------------
# homebrew
#------------------------------------------
# Homebrewのインストール
if ! command -v brew &> /dev/null; then
  echo "==> Homebrewをインストール中..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Apple SiliconとIntelで異なるパスを設定
  if [[ $(uname -m) == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "Homebrewは既にインストール済みです"
fi

# Brewfileからインストール
if [ -f "$HOME/.Brewfile" ]; then
  echo "==> Brewfileのパッケージをインストール中..."
  brew bundle --global

  echo "==> 不要なパッケージをクリーンアップ中..."
  brew bundle cleanup --global --force
else
  echo "警告: .Brewfileが見つかりません"
fi

# iTerm2の設定同期 (ファイルが存在する場合のみ)

# if [ -f "${DOTFILES_DIR}/iterm2/com.googlecode.iterm2.plist" ]; then
#   echo "==> iTerm2の設定を同期中..."
#   mkdir -p "$HOME/Library/Preferences"
#   cp -f "${DOTFILES_DIR}/iterm2/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
#   defaults read com.googlecode.iterm2 > /dev/null 2>&1  # 設定を読み込む
# fi

# macOS設定の適用
if [ -f "${DOTFILES_DIR}/mac/sync.sh" ]; then
  echo "==> macOS設定を適用中..."
  bash "${DOTFILES_DIR}/mac/sync.sh"
fi

echo ""
echo "==> セットアップ完了!"
echo "変更を反映するには、ターミナルを再起動してください"

exec $SHELL -l
