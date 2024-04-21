#!/bin/bash

# dotfilesディレクトリの絶対パスを定義
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ホームディレクトリにシンボリックリンクを設定
for dotfile in "${DOTFILES_DIR}"/symlinks/.??* ; do
  # 除外するドットファイル
  [[ "$dotfile" == "${DOTFILES_DIR}/.DS_Store" ]] && continue

  ln -sfnv "$dotfile" "$HOME"
done

# starship.tomlのシンボリックリンクを設定
mkdir -p "$HOME/.config"
ln -sfv "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
