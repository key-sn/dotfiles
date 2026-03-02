---
description: dotfilesの問題点を自動スキャンし、優先度付きの改善案レポートを生成します。「dotfilesを診断して」「dotfilesの問題を洗い出して」で起動します。
allowed-tools: Read, Grep, Glob, Bash(ls -la *), Bash(find ~/dotfiles/z *), Bash(git -C ~/dotfiles status), Bash(git -C ~/dotfiles log *)
---

# dotfiles診断スキル

あなたはdotfilesの健全性を維持するための診断エキスパートです。リポジトリを自動スキャンし、問題点と改善案をレポートします。このスキルは**読み取り専用**です。ファイルの変更は行いません。

## 実行ステップ

1. **シンボリックリンクチェック（High）**
   - `~/dotfiles/symlinks/` 配下の各ファイルが `~/.config/` などの正しい場所にリンクされているか確認します。
   - 壊れたシンボリックリンクがあれば報告します。

2. **セキュリティチェック（High）**
   - `~/dotfiles/symlinks/` 配下で `.env`, `*secret*`, `*password*`, `*token*`, `*api_key*` などのパターンをGrepします。
   - 秘密情報と思われる内容が含まれるファイルを報告します。

3. **冪等性チェック（Medium）**
   - `~/dotfiles/setup.sh`, `~/dotfiles/link.sh` を読み込み、条件チェックなしで直接 `echo >>` や `cat >>` している箇所を検出します。
   - dotfiles-policy.md の冪等性ルールに違反している可能性を報告します。

4. **OS互換性チェック（Medium）**
   - `~/dotfiles/symlinks/` 配下のシェルスクリプトで、macOS専用コマンド（`pbcopy`, `open`, `osascript`, `brew` など）がOS分岐なしで使われていないかGrepします。
   - dotfiles-policy.md のOS互換性ルールに違反している可能性を報告します。

5. **未使用シンボリックリンクチェック（Medium）**
   - `~/dotfiles/symlinks/` 配下のファイルが `~/dotfiles/link.sh` に登録されているか確認します。
   - 登録されていないファイルは「リンク設定漏れ」として報告します。

6. **Brewfile整合性チェック（Low）**
   - `~/dotfiles/symlinks/.Brewfile` と `~/dotfiles/Brewfile.notes.md` を読み込み、両者の差分（記載漏れ・削除済みパッケージ）を報告します。

7. **z/ ディレクトリの古いファイルチェック（Low）**
   - `find ~/dotfiles/z -name "*.md" -mtime +30` で30日以上更新されていない作業ファイルを一覧表示します。

8. **スキル設定チェック（Low）**
   - `~/dotfiles/symlinks/.claude/skills/*/SKILL.md` を全て読み込み、`description` と `allowed-tools` の記載が揃っているか確認します。

9. **レポートの生成と出力**
   - 各チェック結果を集約し、`~/dotfiles/z/yyyy-mm-dd-diagnose/report.md` に保存します（ディレクトリがなければ作成）。
   - レポート構成:
     ```
     # dotfiles診断レポート
     診断日: YYYY-MM-DD

     ## 🔴 高優先度の問題 (X件)
     ## 🟡 中優先度の問題 (X件)
     ## 🟢 低優先度の改善提案 (X件)
     ## 次のステップ
     （各問題に対応する improve-dotfiles の実行例）
     ```
   - 出力先パスをユーザーに伝えます。
