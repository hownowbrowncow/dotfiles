#!/bin/bash
# macOS System Preferences / Defaults
# Run manually: bash macos_defaults.sh
# Some changes require a logout/restart to take effect.

set -euo pipefail

echo "Applying macOS defaults..."

# ── Keyboard ──────────────────────────────────────────────────────────────────
# Fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# ── Trackpad / Mouse ─────────────────────────────────────────────────────────
# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# ── Finder ────────────────────────────────────────────────────────────────────
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar at the bottom
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ── Dock ──────────────────────────────────────────────────────────────────────
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Remove auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

# Speed up auto-hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Set icon size
defaults write com.apple.dock tilesize -int 48

# Don't show recent applications
defaults write com.apple.dock show-recents -bool false

# Minimize windows using scale effect (faster than genie)
defaults write com.apple.dock mineffect -string "scale"

# ── Screenshots ───────────────────────────────────────────────────────────────
# Save screenshots to ~/Screenshots
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# Save screenshots as PNG
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# ── Safari ────────────────────────────────────────────────────────────────────
# Show the full URL in the address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable the Develop menu and the Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# ── TextEdit ──────────────────────────────────────────────────────────────────
# Use plain text mode by default
defaults write com.apple.TextEdit RichText -int 0

# ── Activity Monitor ─────────────────────────────────────────────────────────
# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# ── Apply Changes ─────────────────────────────────────────────────────────────
echo "Restarting affected applications..."
for app in "Dock" "Finder" "Safari" "SystemUIServer"; do
  killall "${app}" 2>/dev/null || true
done

echo "Done! Some changes may require a logout/restart."
