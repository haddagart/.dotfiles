#!/usr/bin/env bash

# macOS system preferences
# Compatible with: macOS Tahoe (26+), Sequoia (15), Sonoma (14)
# Optimised for: Apple Silicon M1+ · Developer · PhD/AI researcher · Designer
#
# Goals:
#   - Clean, fast, distraction-free environment
#   - Keyboard-first, terminal-native workflow
#   - Battery-conscious defaults
#   - Zero system risk — all user-domain defaults only
#
# Run: bash ~/.dotfiles/install/macos.sh

set -e

source "$(dirname "$0")/../lib/console.sh"

# ── Preflight ──────────────────────────────────────────────────────────────────

# Confirm before applying
center_text "MACOS PREFERENCES"
echo ""
log "This will apply system preferences optimised for developer/designer productivity."
log "Compatible with macOS Tahoe 26+, Sequoia 15, Sonoma 14."
log "All changes are safe and reversible via System Settings."
echo ""
printf "  Apply preferences? [y/N] "
read -r confirm
echo ""
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  log "Skipped. Run again and press y to apply."
  exit 0
fi

# Close System Settings to prevent it from overriding changes
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || \
  killall "System Settings" 2>/dev/null || true

# Ask for sudo upfront and keep the session alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# ── Performance & Animations ──────────────────────────────────────────────────
# Remove all UI animations that add latency without functional benefit.
# The Liquid Glass design in Tahoe is unaffected — these are timing controls only.

center_text "PERFORMANCE & ANIMATIONS"

# Near-instant window resize
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Remove toolbar title rollover delay
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# Disable system-wide window open/close animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable sheet slide-down animation
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Disable Finder window and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Dock: instant show/hide
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Dock: no app bounce on launch
defaults write com.apple.dock launchanim -bool false

# Faster Mission Control animation
defaults write com.apple.dock expose-animation-duration -float 0.1

success "Performance & Animations done"

# ── General UI/UX ─────────────────────────────────────────────────────────────

center_text "GENERAL UI/UX"

# Medium sidebar icon size
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Save panel: always expanded (shows full path — no hunting for save location)
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode  -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Print panel: always expanded
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint  -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk by default, not iCloud (predictable, local file paths)
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Quit printer app when print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Don't reopen windows when relaunching apps (clean slate)
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Keep background apps alive — don't silently kill inactive processes
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Disable Gatekeeper open-anyway dialog
# Intentional: running your own scripts and tools shouldn't require dialogs
# Restore with: defaults write com.apple.LaunchServices LSQuarantine -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable ALL text auto-corrections
# Essential — every substitution can corrupt code, commands, config, and terminal input
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled     -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled   -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled  -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled     -bool false

success "General UI/UX done"

# ── Keyboard & Input ──────────────────────────────────────────────────────────
# Tuned for terminal-heavy, Vim-native, keyboard-driven workflow.

center_text "KEYBOARD & INPUT"

# Fastest key repeat (critical for Vim hjkl navigation and terminal editing)
# Note: takes effect after logout/restart
defaults write NSGlobalDomain KeyRepeat        -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Disable press-and-hold accent picker — use key repeat instead
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Tab navigates ALL UI controls, not just text boxes (keyboard-first navigation)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Trackpad: tap to click (built-in trackpad)
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# Trackpad: tap to click (Bluetooth/external trackpad)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Three-finger drag — move windows ergonomically without force-clicking
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Bottom-right corner = secondary click (right-click)
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick       -bool true

# Four-finger swipe: switch Spaces (horizontal) and Mission Control (vertical)
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture  -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture  -int 2

# Three-finger swipe left/right: switch full-screen apps
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Ctrl+scroll to zoom (useful for inspecting design output or code diffs)
defaults write com.apple.universalaccess closeViewScrollWheelToggle  -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask   -int 262144
defaults write com.apple.universalaccess closeViewZoomFollowsFocus   -bool true

success "Keyboard & Input done"

# ── Screen & Display ──────────────────────────────────────────────────────────

center_text "SCREEN & DISPLAY"

# Require password immediately after sleep (no grace period — security)
defaults write com.apple.screensaver askForPassword      -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screenshots: PNG, saved to Desktop, no drop shadow, with timestamp
defaults write com.apple.screencapture location        -string "${HOME}/Desktop"
defaults write com.apple.screencapture type            -string "png"
defaults write com.apple.screencapture disable-shadow  -bool true
defaults write com.apple.screencapture include-date    -bool true

# Light font smoothing for non-Apple external displays
defaults write NSGlobalDomain AppleFontSmoothing -int 1

success "Screen & Display done"

# ── Finder ────────────────────────────────────────────────────────────────────
# A power-user file browser: maximum info density, zero friction, dotfiles visible.

center_text "FINDER"

# Allow quitting Finder with ⌘Q (free RAM when not needed)
defaults write com.apple.finder QuitMenuItem -bool true

# Disable Finder window and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# New Finder windows open to home folder
defaults write com.apple.finder NewWindowTarget     -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show hidden files — dotfiles, .env, .git, config dirs are always visible
defaults write com.apple.finder AppleShowAllFiles -bool true

# Always show file extensions — no surprises with file types
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar: item count + available disk space
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar: breadcrumb navigation at the bottom
defaults write com.apple.finder ShowPathbar -bool true

# Full POSIX path in the window title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Folders always on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst          -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# Search scope: current folder by default (not the entire Mac)
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# No warning when changing a file's extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# No confirmation before emptying Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Spring loading: hover over a folder to drill in while dragging
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay   -float 0

# Never write .DS_Store to network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores     -bool true

# Desktop: show external drives and removable media; hide internal drive
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop     -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop     -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop         -bool false

# Default view: list (highest information density)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# ~/Library: always visible (for config editing, dotfile debugging)
chflags nohidden ~/Library
xattr -d com.apple.FinderInfo ~/Library 2>/dev/null || true

# /Volumes: always visible
sudo chflags nohidden /Volumes

# Expand these panels in Get Info (⌘I): General, Open With, Sharing & Permissions
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General    -bool true \
  OpenWith   -bool true \
  Privileges -bool true

success "Finder done"

# ── Dock & Mission Control ────────────────────────────────────────────────────
# Minimal Dock — launch apps via Spotlight. Use Spaces for focus.

center_text "DOCK & MISSION CONTROL"

# Auto-hide Dock — reclaim screen real estate
defaults write com.apple.dock autohide -bool true

# Show only currently open apps (no pinned app row)
defaults write com.apple.dock static-only -bool true

# Don't show recent apps section
defaults write com.apple.dock show-recents -bool false

# Icon size: compact
defaults write com.apple.dock tilesize -int 36

# Scale minimize effect (faster than genie)
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into the app icon (keeps Dock uncluttered)
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator dots under open apps
defaults write com.apple.dock show-process-indicators -bool true

# Hidden apps show as translucent in the Dock (visual status cue)
defaults write com.apple.dock showhidden -bool true

# Highlight stack items on hover
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Don't auto-rearrange Spaces by most recent use (keep your layout stable)
defaults write com.apple.dock mru-spaces -bool false

# Mission Control: flat window layout — don't group by app
defaults write com.apple.dock expose-group-by-app -bool false

# Hot corners — designed for minimal hand travel
# Values: 0=none 2=Mission Control 3=App Windows 4=Desktop
#         5=Screen Saver 10=Sleep Display 11=Launchpad 12=Notification Center 13=Lock Screen
defaults write com.apple.dock wvous-tl-corner    -int 2   # Top-left     → Mission Control
defaults write com.apple.dock wvous-tl-modifier  -int 0
defaults write com.apple.dock wvous-tr-corner    -int 13  # Top-right    → Lock Screen
defaults write com.apple.dock wvous-tr-modifier  -int 0
defaults write com.apple.dock wvous-bl-corner    -int 4   # Bottom-left  → Desktop
defaults write com.apple.dock wvous-bl-modifier  -int 0
defaults write com.apple.dock wvous-br-corner    -int 10  # Bottom-right → Sleep Display
defaults write com.apple.dock wvous-br-modifier  -int 0

success "Dock & Mission Control done"

# ── Energy & Battery ──────────────────────────────────────────────────────────
# M1-safe. No hibernatemode changes — Apple Silicon requires mode 3 (safe sleep).
# Tuned for long build/SSH sessions on charger, battery conservation off charger.

center_text "ENERGY & BATTERY"

# Wake reliably on lid open
sudo pmset -a lidwake 1

# Auto-restart after unexpected power loss
sudo pmset -a autorestart 1

# ── On charger: optimise for uninterrupted work ──
# Machine never sleeps (long builds, CI, SSH, Docker)
sudo pmset -c sleep 0
# Disk never sleeps while charging
sudo pmset -c disksleep 0
# Display sleeps after 20 min
sudo pmset -c displaysleep 20
# Power Nap on charger: allow background sync and updates
sudo pmset -c powernap 1

# ── On battery: conserve power ──
# Display sleeps after 8 min
sudo pmset -b displaysleep 8
# Machine sleeps after 15 min
sudo pmset -b sleep 15
# Disk sleeps after 10 min on battery
sudo pmset -b disksleep 10
# Disable Power Nap on battery (prevents background drain)
sudo pmset -b powernap 0
# Disable proximity wake on battery (Wi-Fi handoff keeps radio awake)
sudo pmset -b proximitywake 0

# ── All power states ──
# 24-hour standby delay (default is 1h — avoids the slow deep-standby wake penalty)
sudo pmset -a standbydelay 86400

success "Energy & Battery done"

# ── Developer Tools ───────────────────────────────────────────────────────────
# Settings that directly reduce friction in a daily dev/research workflow.

center_text "DEVELOPER TOOLS"

# Ensure ~/Developer exists (standard Xcode/project root)
mkdir -p ~/Developer

# Crash reports as Notification Center banners, not blocking modal dialogs
defaults write com.apple.CrashReporter DialogType "notification"
defaults write com.apple.CrashReporter UseUNC 1

# TextEdit: plain text + UTF-8 by default (quick scratch pad, config snippets)
defaults write com.apple.TextEdit RichText                -int 0
defaults write com.apple.TextEdit PlainTextEncoding       -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# QuickTime: auto-play on open
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

# Terminal.app: UTF-8 only
defaults write com.apple.terminal StringEncodings -array 4

# Terminal.app: Secure Keyboard Entry (protect keystrokes from other processes)
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Terminal.app: disable shell line markers (cleaner scrollback for dev output)
defaults write com.apple.Terminal ShowLineMarks -int 0

# Safari: show full URL (no hiding scheme or path)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Safari: enable Develop menu and Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu                                                        -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey                                 -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# Right-click → Inspect Element in any app using a WebView
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Safari: don't auto-open downloaded files
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Safari: don't send queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled       -bool false
defaults write com.apple.Safari SuppressSearchSuggestions    -bool true

# Safari: disable all AutoFill (use a dedicated password manager)
defaults write com.apple.Safari AutoFillFromAddressBook    -bool false
defaults write com.apple.Safari AutoFillPasswords          -bool false
defaults write com.apple.Safari AutoFillCreditCardData     -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Safari: warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Safari: auto-update extensions
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

success "Developer Tools done"

# ── Spotlight ─────────────────────────────────────────────────────────────────
# Focused result set: apps, system prefs, folders, docs, PDFs, source code.
# Web search, suggestions, and media categories disabled to reduce noise.

center_text "SPOTLIGHT"

defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "DOCUMENTS";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

killall mds 2>/dev/null || true
sudo mdutil -i on / >/dev/null
sudo mdutil -E / >/dev/null

success "Spotlight done"

# ── Security ──────────────────────────────────────────────────────────────────

center_text "SECURITY"

# Require password immediately after sleep or screen saver
defaults write com.apple.screensaver askForPassword      -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Login window: show username + password fields, not a list of users
sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

success "Security done"

# ── App Store & Updates ───────────────────────────────────────────────────────

center_text "APP STORE & UPDATES"

# Check for updates daily
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency     -int 1

# Download updates in the background (ready when you choose to install)
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Auto-install security patches and system data files
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Auto-update App Store apps
defaults write com.apple.commerce AutoUpdate -bool true

success "App Store & Updates done"

# ── Activity Monitor ──────────────────────────────────────────────────────────

center_text "ACTIVITY MONITOR"

# Open main window on launch
defaults write com.apple.ActivityMonitor OpenMainWindow  -bool true
# Dock icon shows CPU history graph (useful when debugging perf issues)
defaults write com.apple.ActivityMonitor IconType        -int 5
# Show all processes (not just user-owned)
defaults write com.apple.ActivityMonitor ShowCategory    -int 0
# Default sort: highest CPU usage first
defaults write com.apple.ActivityMonitor SortColumn      -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection   -int 0

success "Activity Monitor done"

# ── Misc Apps ─────────────────────────────────────────────────────────────────

center_text "MISC APPS"

# Photos: don't auto-open when plugging in iPhone/camera
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Time Machine: don't prompt to use every newly plugged disk
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Mail: no animations, plain address copies, no inline attachment previews
defaults write com.apple.mail DisableReplyAnimations            -bool true
defaults write com.apple.mail DisableSendAnimations             -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard  -bool false
defaults write com.apple.mail DisableInlineAttachmentViewing    -bool true
defaults write com.apple.mail SpellCheckingBehavior             -string "NoSpellCheckingEnabled"

# Messages: no curly quotes or spell check (copy/paste code snippets safely)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings \
  -dict-add "automaticQuoteSubstitutionEnabled" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings \
  -dict-add "continuousSpellCheckingEnabled" -bool false

success "Misc Apps done"

# ── Restart affected services ─────────────────────────────────────────────────

center_text "APPLYING CHANGES"

for app in \
  "Activity Monitor" "cfprefsd" "Dock" "Finder" \
  "Mail" "Messages" "Photos" "Safari" "SystemUIServer"; do
  killall "$app" &>/dev/null || true
done

center_text "MACOS PREFERENCES APPLIED"
echo ""
log "Keyboard repeat rate and login window changes require a logout or restart."
