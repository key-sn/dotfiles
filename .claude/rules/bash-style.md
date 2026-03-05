# Bash コマンドスタイルガイド

<!-- このファイルは && 複合コマンドが permissions で弾かれる問題への暫定対処です。
     削除条件を必ず確認してから消してください → 末尾の「このファイルの削除条件」参照 -->

## ルール

Bash ツールを呼び出す際は、`&&` や `||` を使った複合コマンドを避け、
**コマンドを1つずつ個別の Bash ツール呼び出しに分けること。**

### 具体例

```
# NG: 複合コマンド
git add . && git commit -m "message"

# OK: 個別に分ける
git add .
# (次の呼び出しで)
git commit -m "message"
```

```
# NG: cd + コマンド
cd /path/to/dir && ls

# OK: 絶対パスを使う
ls /path/to/dir
```

### 例外（許可）

パイプ（`|`）は出力加工目的に限り使用可。

```
# OK: パイプは許可
git log --oneline | head -10
```

---

## このファイルの削除条件

以下のいずれかに該当したら削除を検討する。

### 条件: Claude Code の permissions が複合コマンドを分解評価するようになった

GitHub Issues で解決が確認できたら不要になる:
- https://github.com/anthropics/claude-code/issues/29491

### 確認手順

1. dotfiles プロジェクトで `Bash(git add *)` が許可されている状態で、
   Claude に `git add . && git status` を実行させてみる
2. 確認プロンプトが出ずに実行されたら、このルールは不要

### 削除方法

```bash
git rm .claude/rules/bash-style.md
git commit -m "remove: bash-style rule (no longer needed)"
```
