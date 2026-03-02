#!/usr/bin/env bash
# 通知クリック時に呼ばれる iTerm2 フォーカススクリプト

TTY_PATH=$(cat /tmp/claude-code-last-tty 2>/dev/null | tr -d '[:space:]')

if [[ -z "$TTY_PATH" ]]; then
  # TTY 不明時は iTerm2 をアクティベートするだけ
  osascript -e 'tell application "iTerm2" to activate'
  exit 0
fi

# AppleScript で TTY が一致するセッションを特定しフォーカス
osascript << APPLESCRIPT
tell application "iTerm2"
  activate
  repeat with aWindow in windows
    repeat with aTab in tabs of aWindow
      repeat with aSession in sessions of aTab
        if tty of aSession is "${TTY_PATH}" then
          tell aWindow
            select
            set frontmost to true
          end tell
          tell aTab to select
          tell aSession to select
          return
        end if
      end repeat
    end repeat
  end repeat
end tell
APPLESCRIPT
