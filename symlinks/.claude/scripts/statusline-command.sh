#!/usr/bin/env bash
# Claude Code ステータスライン表示スクリプト
# 表示内容: モデル名 | プロジェクト名 | コンテキスト使用率 | 累積トークン数

INPUT=$(cat)

# モデル表示名
MODEL=$(echo "$INPUT" | jq -r '.model.display_name // .model.id // "Unknown"')

# プロジェクト名（session_name があればそれ、なければ workspace のディレクトリ名）
SESSION_NAME=$(echo "$INPUT" | jq -r '.session_name // empty')
if [ -n "$SESSION_NAME" ]; then
  PROJECT="$SESSION_NAME"
else
  PROJECT=$(echo "$INPUT" | jq -r '.workspace.project_dir // .workspace.current_dir // .cwd // ""' | xargs basename 2>/dev/null)
fi

# コンテキスト使用率
USED_PCT=$(echo "$INPUT" | jq -r '.context_window.used_percentage // empty')

# 累積トークン数（input + output の合計）
TOTAL_IN=$(echo "$INPUT" | jq -r '.context_window.total_input_tokens // 0')
TOTAL_OUT=$(echo "$INPUT" | jq -r '.context_window.total_output_tokens // 0')
TOTAL_TOKENS=$(( TOTAL_IN + TOTAL_OUT ))

# トークン数を k 単位で整形
if [ "$TOTAL_TOKENS" -ge 1000 ]; then
  TOKEN_STR="$(awk "BEGIN {printf \"%.1fk\", $TOTAL_TOKENS/1000}")"
else
  TOKEN_STR="${TOTAL_TOKENS}"
fi

# 出力組み立て
PARTS=()
PARTS+=("$MODEL")

if [ -n "$PROJECT" ]; then
  PARTS+=("$PROJECT")
fi

if [ -n "$USED_PCT" ]; then
  PARTS+=("ctx: ${USED_PCT}%")
fi

if [ "$TOTAL_TOKENS" -gt 0 ]; then
  PARTS+=("tokens: ${TOKEN_STR}")
fi

# " | " で結合して出力
( IFS='|'; echo " ${PARTS[*]} " | sed 's/|/ | /g' )
