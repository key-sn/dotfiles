#!/usr/bin/env bash
# Claude Code 通知フック
# 通知をクリックすると、Claude Code が動作中の iTerm2 セッションにフォーカスする

set -euo pipefail

# macOS 以外では何もしない（OS互換性ルール準拠）
[[ "$(uname)" != "Darwin" ]] && exit 0

# stdin から JSON を読み込む（読み取り失敗時は空文字で継続）
INPUT=$(cat 2>/dev/null || echo '{}')
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // "Unknown"' 2>/dev/null || echo "Unknown")

# イベント種別に応じたメッセージ・サウンド
case "$EVENT" in
  "Notification") MESSAGE="応答が必要です";    SOUND="Glass" ;;
  "Stop")         MESSAGE="作業が完了しました"; SOUND="Ping"  ;;
  *)              MESSAGE="Claude Code";        SOUND="Glass" ;;
esac

# Claude Code が動いている TTY を取得し /tmp に保存
# プロセスツリー: notify.sh($$) → Claude Code(PPID)
TTY_NAME=$(ps -o tty= -p "${PPID}" 2>/dev/null | tr -d ' ')
if [[ -n "$TTY_NAME" && "$TTY_NAME" != "??" ]]; then
  echo "/dev/${TTY_NAME}" > /tmp/claude-code-last-tty
fi

FOCUS_SCRIPT="$HOME/.claude/hooks/iterm-focus.sh"

if command -v terminal-notifier &>/dev/null; then
  terminal-notifier \
    -title "Claude Code" \
    -message "${MESSAGE}" \
    -sender "com.anthropic.claudefordesktop" \
    -sound "${SOUND}" \
    -execute "bash '${FOCUS_SCRIPT}'"
else
  # フォールバック: terminal-notifier 未インストール時は従来通知
  osascript -e "display notification \"${MESSAGE}\" with title \"Claude Code\" sound name \"${SOUND}\""
fi
