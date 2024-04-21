#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

# ====================
#
# Base
#
# ====================

# 文頭を自動で大文字にしないようにする
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# ====================
#
# Dock
#
# ====================

# Dockの位置を左に変更
defaults write com.apple.dock orientation left

# Dockのアイコンサイズを変更
defaults write com.apple.dock "tilesize" -int "36"

# Dockを自動で表示/非表示にする
defaults write com.apple.dock "autohide" -bool "true"

# Dockが表示されるまでの待機時間を変更
defaults write com.apple.dock "autohide-delay" -float "0.1"

# ====================
#
# Finder
#
# ====================

# デフォルトで隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles -bool true

# 全ての拡張子のファイルを表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# ステータスバー(残ストレージ容量)を表示
defaults write com.apple.finder ShowStatusBar -bool true

# パスバー(pathのリスト)を表示
defaults write com.apple.finder ShowPathbar -bool true

# 終了オプションの追加(cmd + qで終了できるようになる)
defaults write com.apple.finder "QuitMenuItem" -bool "true"

# ファイル表示をカラムにする
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# USBやネットワークストレージに.DS_Storeファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ====================
#
# SystemUIServer
#
# ====================

# 日付、曜日、時間の表記にする
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm'

# バッテリー残量を％表記にする
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# スクリーンショットの保存場所をPicturesに変更
defaults write com.apple.screencapture "location" -string "~/Pictures"

# マウス加速をオフにする(再起動で反映)
defaults write NSGlobalDomain com.apple.mouse.linear -bool "true"

# マウスの軌跡の速さを変更(再起動で反映)
defaults write NSGlobalDomain com.apple.mouse.scaling -float "3.0"

# Spotlight検索のショートカットを無効化(再起動で反映)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"

# アプリケーションを終了するときにウインドウを閉じない(iTermでウインドウを復元するのに必要)
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -boolean false

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
