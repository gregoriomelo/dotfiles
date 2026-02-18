#!/bin/bash
# macOS system preferences for developer experience

# Keyboard
# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable auto-correct, capitalize, smart quotes
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Dock
# Auto-hide
defaults write com.apple.dock autohide -bool true

# No delay on reveal
defaults write com.apple.dock autohide-delay -float 0

# Don't show recent apps
defaults write com.apple.dock show-recents -bool false

# Reasonable icon size (48)
defaults write com.apple.dock tilesize -int 48

# Finder
# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Use list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Sort folders first
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Don't create .DS_Store on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Trackpad
# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Screenshots
# Save to ~/Screenshots as PNG
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots
defaults write com.apple.screencapture type -string "png"

# No shadow on screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Misc
# Expand save/print panels
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Disable quarantine warning dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "macOS defaults applied"
