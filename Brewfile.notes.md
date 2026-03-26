# Brewfile Notes

`.Brewfile` に記載されたパッケージの用途・選定理由をまとめたドキュメント。
`brew bundle dump` で `.Brewfile` が自動更新されるため、コメントはこのファイルで管理する。

最終更新: 2026-03-26

---

## Formulae

| パッケージ | 用途・備考 |
|---|---|
| awscli | AWS CLI |
| direnv | ディレクトリごとの環境変数管理 |
| docker | Docker CLI |
| fujiwara/tap/ecsta | （用途を記載してください） |
| gh | GitHub CLI |
| git | バージョン管理 |
| jq | JSON パーサ CLI |
| mysql@8.0 | ローカル開発用 DB |
| peco | ctrl+r 履歴検索に使用（.zshrc 参照） |
| rbenv | Ruby バージョン管理 |
| ruby-build | rbenv のプラグイン |
| starship | zsh プロンプトのカスタマイズ |
| terminal-notifier | macOS 通知センターへの CLI 通知送信（Claude Code フック用） |
| wget | ファイルダウンロード CLI |
| yarn | Node.js パッケージマネージャ |
| zsh-autosuggestions | zsh の入力補完 |

---

## Casks

| パッケージ | 用途・備考 |
|---|---|
| alfred | ランチャー（Raycast に移行中、削除候補） |
| aws-vpn-client | 仕事用 AWS VPN |
| claude-code | Claude Code CLI |
| cmux | （用途を記載してください） |
| discord | コミュニティ |
| docker-desktop | Docker GUI |
| firefox | サブブラウザ |
| font-hack-nerd-font | ターミナル用 Nerd Font |
| google-chrome | メインブラウザ |
| iterm2 | ターミナル |
| karabiner-elements | キーボードカスタマイズ |
| notion | ドキュメント管理 |
| raycast | ランチャー（alfred の後継として使用中） |
| rectangle | ウィンドウ管理 |
| sequel-ace | MySQL GUI クライアント |
| slack | 仕事用コミュニケーション |
| visual-studio-code | エディタ |

---

## VS Code Extensions

| 拡張機能 ID | 用途・備考 |
|---|---|
| aliariff.slim-lint | Slim テンプレートの Lint |
| anthropic.claude-code | Claude Code VS Code 連携 |
| dbaeumer.vscode-eslint | ESLint 連携 |
| docker.docker | Docker 連携 |
| esbenp.prettier-vscode | コードフォーマッタ |
| github.copilot-chat | GitHub Copilot Chat |
| github.vscode-github-actions | GitHub Actions 連携 |
| hashicorp.terraform | Terraform 連携 |
| janisdd.vscode-edit-csv | CSV 編集 |
| mechatroner.rainbow-csv | CSV カラー表示 |
| ms-azuretools.vscode-containers | Dev Containers 連携 |
| ms-azuretools.vscode-docker | Docker 連携（旧） |
| ms-ceintl.vscode-language-pack-ja | 日本語 UI |
| ms-vscode-remote.remote-containers | Remote Containers |
| ms-vscode.makefile-tools | Makefile 連携 |
| shopify.ruby-lsp | Ruby LSP（Shopify 製） |
| sianglim.slim | Slim テンプレートのシンタックスハイライト |
| vscodevim.vim | Vim キーバインド |
