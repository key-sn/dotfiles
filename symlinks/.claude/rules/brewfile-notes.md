# Brewfile.notes.md の更新ルール

sync-dotfiles の実行時、以下のルールに従って `~/dotfiles/Brewfile.notes.md` を更新すること。

## 更新のトリガー

sync-dotfiles スキルの実行時（`git status` 確認後、コミット前）

## 更新手順

1. **現在の `.Brewfile` を読み込む**: `~/dotfiles/symlinks/.Brewfile` の内容を読み込み、
   brew / cask / vscode の各エントリ一覧を取得する。

2. **現在の `Brewfile.notes.md` を読み込む**: `~/dotfiles/Brewfile.notes.md` を読み込み、
   各テーブルに記載されているパッケージ一覧を取得する。

3. **追加されたパッケージを反映する**: `.Brewfile` にあって `Brewfile.notes.md` の対応テーブルに
   ないものは、テーブルに行を追加する。
   - 用途が一般的に明らかなものは日本語で簡潔に記述する
   - 不明な場合は「（用途を記載してください）」とする

4. **削除されたパッケージを反映する**: `Brewfile.notes.md` のテーブルにあって `.Brewfile` に
   ないものは、テーブルから行を削除する。

5. **既存の記述は変更しない**: すでに用途が記載されているパッケージの説明を勝手に書き換えない。

6. **最終更新日を更新する**: ファイル冒頭の「最終更新: YYYY-MM-DD」を今日の日付に更新する。

## ファイルフォーマット

- セクション: `## Formulae` / `## Casks` / `## VS Code Extensions` の3つ
- 各セクション: マークダウンテーブル（`| パッケージ | 用途・備考 |`）
- 並び順: アルファベット順
- ファイルパス: `~/dotfiles/Brewfile.notes.md`（dotfiles リポジトリルート直下、シンボリックリンク対象外）
