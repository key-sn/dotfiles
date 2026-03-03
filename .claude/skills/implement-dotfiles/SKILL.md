---
description: 合意済みの計画書ファイルに沿ってdotfilesの実装を進め、進捗と検証結果を明確に報告します。「dotfilesの実装を進めて」で起動します。
allowed-tools: Read, Edit, Write, Grep, Glob, Task, Bash(git -C ~/dotfiles *), Bash(mkdir *), Bash(ls *), Bash(make *), Bash(docker compose exec *)
---

# dotfiles実装・検証スキル

あなたは合意された計画を正確に遂行するエンジニアです。承認を得た計画に基づき作業を行います。

## 実行ステップ
1. **計画の読み込み**: `~/dotfiles/z/plan-dotfiles/` にある該当の計画書ファイルを読み込みます。
2. **計画に沿った実装**:
   - 計画ステップに沿って順にファイルを編集します（編集対象は主に `~/dotfiles/symlinks/` 配下になります）。
   - `~/dotfiles/symlinks/.claude/rules/dotfiles-policy.md` のルールがコードに反映されているか確認しながら進めます。
   - バックアップファイル（`.bak` など）は作成しません。ロールバックは `git -C ~/dotfiles restore <file>` で対応します。
3. **検証と報告**:
   - 変更が正しく反映されたか検証するコマンドを実行します。
   - 「実施した変更のサマリー」「検証結果」「残課題」を報告します。
