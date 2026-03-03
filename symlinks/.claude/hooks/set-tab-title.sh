#!/usr/bin/env bash
# iTerm2のタブタイトルをClaude Codeの状態に応じて更新する
# PreToolUse: 実行中のツール名を表示
# Stop: 待機中（CC: project）に戻す

set -euo pipefail
[[ "$(uname)" != "Darwin" ]] && exit 0

INPUT=$(cat 2>/dev/null || echo '{}')
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // "Unknown"' 2>/dev/null || echo "Unknown")
TOOL=$(echo "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null || echo "")

# ccコマンド経由で起動した場合はラベルを優先、そうでなければディレクトリ名
PROJECT="${CLAUDE_TAB_LABEL:-$(basename "$PWD")}"

case "$EVENT" in
  "PreToolUse")
    [[ -n "$TOOL" ]] && TITLE="⚡${TOOL} | ${PROJECT}" || TITLE="⚡実行中 | ${PROJECT}"
    ;;
  "Stop")
    TITLE="CC: ${PROJECT}"
    ;;
  *)
    TITLE="CC: ${PROJECT}"
    ;;
esac

# Claude CodeのTTYにエスケープシーケンスを書き込んでタブタイトルを変更
TTY_NAME=$(ps -o tty= -p "${PPID}" 2>/dev/null | tr -d ' ')
if [[ -n "$TTY_NAME" && "$TTY_NAME" != "??" ]]; then
  printf '\033]0;%s\007' "${TITLE}" > "/dev/${TTY_NAME}"
fi
