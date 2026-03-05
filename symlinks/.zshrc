# Homebrewのパスを優先して設定
export PATH="/opt/homebrew/bin:$PATH"

# brew install/uninstall 時に .Brewfile を自動更新する wrapper
# macOS 限定（brew bundle は macOS 専用）
if [[ "$(uname)" == "Darwin" ]]; then
  brew() {
    command brew "$@"
    local exit_code=$?
    [[ $exit_code -ne 0 ]] && return $exit_code

    local brewfile="${HOMEBREW_BUNDLE_FILE:-$HOME/.Brewfile}"
    case "$1" in
      install|uninstall|remove|rm|tap|untap)
        [[ -f "$brewfile" ]] && command brew bundle dump --global --force 2>/dev/null
        ;;
    esac

    return $exit_code
  }
fi

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

# Claude Codeをタブタイトル付きで起動する関数
# 使い方: cc [ラベル] [claudeへの引数...]
#   cc                    → タイトル "CC: ディレクトリ名"
#   cc "auth"             → タイトル "CC: auth"
#   cc "auth" "/skill"    → タイトル "CC: auth"、claude に "/skill" を渡す
function cc() {
  local label="${1:-$(basename "$PWD")}"
  printf '\033]0;CC: %s\007' "$label"
  CLAUDE_TAB_LABEL="$label" claude "${@:2}"
  printf '\033]0;%s\007' "$(basename "$PWD")"
}

# ターミナルのタブタイトルを現在のディレクトリ名にする関数
function precmd() {
  echo -ne "\033]0;${PWD##*/}\007"
}

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
