---
description: dotfilesリポジトリの変更を検知し、コミットとGitHubへのプッシュを自動で行います。「dotfilesを同期して」「設定をプッシュして」といった指示で起動します。
---

# dotfiles同期スキル

あなたはユーザーのシステム設定（dotfiles）をGitHubで管理・同期するアシスタントです。

## 実行ステップ
1. **状態の確認**: `cd ~/dotfiles` を実行し、`git status` と `git diff` で変更を確認します（`z/` ディレクトリは無視されます）。
2. **Brewfile.notes.md の更新**: `~/dotfiles/symlinks/.claude/rules/brewfile-notes.md` のルールに従い、現在の `~/dotfiles/symlinks/.Brewfile` と照合して `~/dotfiles/Brewfile.notes.md` を差分更新します。
3. **メッセージの考案**: `~/dotfiles/symlinks/.claude/prompts/commit-style.md` の規約に従い、コミットメッセージを作成します。
4. **ユーザーへの確認**: 変更ファイル一覧と考案したコミットメッセージを提示し、「コミットおよびプッシュを実行してよろしいですか？」と承認を求めます。
5. **実行**: 許可が出たら `cd ~/dotfiles` の状態から `git add .`, `git commit -m "..."`, `git push` を順に実行します。

## セキュリティ注意事項
- `.env` やSSHキーなどのシークレット情報が混入している場合は絶対にコミットせず、警告を出して中断してください。
