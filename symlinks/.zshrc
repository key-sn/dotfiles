# Homebrewのパスを優先して設定
export PATH="/opt/homebrew/bin:$PATH"

# rbenvの初期化
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# ctrl + r で過去に実行したコマンドを選択できるようにする。
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

alias d='docker'
alias dc='docker compose'
alias cdp='cd ~/projects'
alias bi='bundle install'
alias be='bundle exec'

# Claude Codeを用いたdotfiles管理コマンド
alias dot-sync='cd ~/dotfiles && claude "/sync-dotfiles"'
alias dot-improve='cd ~/dotfiles && claude "/improve-dotfiles"'

# 特定のツールの設定をすぐに調査・ブラッシュアップしたい時用
# 使い方: dot-tweak tmux
dot-tweak() {
  if [ -z "$1" ]; then
    echo "使用法: dot-tweak <ツール名>"
    return 1
  fi
  cd ~/dotfiles && claude "$1 の設定をブラッシュアップしたいので、/improve-dotfiles のワークフローを開始して"
}

# starshipをセットアップ
eval "$(starship init zsh)"

# zsh-autosuggestionsのセットアップ
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# bundle install時のmysql2エラー対策
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix zstd)/lib/
export PATH=$HOME/.nodebrew/current/bin:$PATH
