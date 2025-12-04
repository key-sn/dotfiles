# dotfiles

## Init

```
DIR="$HOME/.dotfiles" && TMP="$DIR/tmp.zip" && mkdir -p "$DIR" && curl -L https://github.com/<USER>/<REPO>/archive/refs/heads/main.zip -o "$TMP" && tar -xf "$TMP" --strip-components=1 -C "$DIR" && rm "$TMP" && sh "$DIR/setup.sh"
```

## Manual

以下は公式の同期を利用
- Google Chrome
- Visual Studio Code
  - GitHub Accountで同期
