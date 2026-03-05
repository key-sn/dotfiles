#!/usr/bin/env bash
# Claude Code 通知フック
# 通知をクリックすると、Claude Code が動作中の iTerm2 セッションにフォーカスする

set -euo pipefail

# macOS 以外では何もしない（OS互換性ルール準拠）
[[ "$(uname)" != "Darwin" ]] && exit 0

# stdin から JSON を読み込む（読み取り失敗時は空文字で継続）
INPUT=$(cat 2>/dev/null || echo '{}')
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // "Unknown"' 2>/dev/null || echo "Unknown")
NOTIF_TYPE=$(echo "$INPUT" | jq -r '.notification_type // ""' 2>/dev/null || echo "")
CWD=$(echo "$INPUT" | jq -r '.cwd // ""' 2>/dev/null || echo "")
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // ""' 2>/dev/null || echo "")

# in_progressなタスクのcontentを取得
TASK_TEXT=""
if [[ -n "$SESSION_ID" ]]; then
  for todos_file in "${HOME}/.claude/todos/${SESSION_ID}"-agent-*.json; do
    if [[ -f "$todos_file" ]]; then
      task=$(jq -r '[.[] | select(.status == "in_progress") | .content] | first // ""' \
              "$todos_file" 2>/dev/null || echo "")
      if [[ -n "$task" ]]; then
        TASK_TEXT="$task"
        break
      fi
    fi
  done
fi

# 通知タイトル: in_progressタスク > CLAUDE_TAB_LABEL > JSON の cwd basename > $PWD basename
if [[ -n "$TASK_TEXT" ]]; then
  TITLE="$TASK_TEXT"
elif [[ -n "${CLAUDE_TAB_LABEL:-}" ]]; then
  TITLE="$CLAUDE_TAB_LABEL"
elif [[ -n "$CWD" ]]; then
  TITLE="$(basename "$CWD")"
else
  TITLE="$(basename "$PWD")"
fi

# イベント・通知タイプ別のメッセージとサウンド
case "$EVENT" in
  "Notification")
    case "$NOTIF_TYPE" in
      "permission_prompt") MESSAGE="承認が必要です";  SOUND="Glass" ;;
      "idle_prompt")       MESSAGE="入力待ちです";    SOUND="Glass" ;;
      *)                   MESSAGE="応答が必要です";  SOUND="Glass" ;;
    esac
    ;;
  "Stop")
    MESSAGE="作業が完了しました"
    SOUND="Ping"
    ;;
  *)
    MESSAGE="Claude Code"
    SOUND="Glass"
    ;;
esac

# Claude Code が動いている TTY を取得し /tmp に保存
TTY_NAME=$(ps -o tty= -p "${PPID}" 2>/dev/null | tr -d ' ')
if [[ -n "$TTY_NAME" && "$TTY_NAME" != "??" ]]; then
  echo "/dev/${TTY_NAME}" > /tmp/claude-code-last-tty
fi

FOCUS_SCRIPT="$HOME/.claude/hooks/iterm-focus.sh"

if command -v terminal-notifier &>/dev/null; then
  terminal-notifier \
    -title "$TITLE" \
    -message "$MESSAGE" \
    -sound "$SOUND" \
    -execute "bash '${FOCUS_SCRIPT}'"
else
  # フォールバック: terminal-notifier 未インストール時は osascript
  osascript -e "display notification \"${MESSAGE}\" with title \"${TITLE}\" sound name \"${SOUND}\""
fi
