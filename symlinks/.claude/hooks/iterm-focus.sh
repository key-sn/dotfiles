#!/usr/bin/env bash
# 通知クリック時に呼ばれる iTerm2 フォーカススクリプト

TTY_PATH=$(cat /tmp/claude-code-last-tty 2>/dev/null | tr -d '[:space:]')

if [[ -z "$TTY_PATH" ]]; then
  # TTY 不明時は iTerm2 をアクティベートするだけ
  osascript -e 'tell application "iTerm2" to activate'
  exit 0
fi

# AppleScript で TTY が一致するセッションを特定しフォーカス
# ※ set frontmost / return は iTerm2 AppleScript では使用不可（-10000 エラー）
osascript << APPLESCRIPT
tell application "iTerm2"
  activate
  set found to false
  repeat with w in windows
    repeat with t in tabs of w
      repeat with s in sessions of t
        if tty of s is "${TTY_PATH}" then
          tell w to select
          tell t to select
          tell s to select
          set found to true
          exit repeat
        end if
      end repeat
      if found then exit repeat
    end repeat
    if found then exit repeat
  end repeat
end tell
APPLESCRIPT
