# macOS Preferences

Documented reference for [`install/macos.sh`](install/macos.sh).

Compatible with **macOS Ventura (13), Sonoma (14), Sequoia (15)**.

Run with:

```sh
bash ~/.dotfiles/install/macos.sh
```

> Some changes require a **logout or restart** to take full effect (key repeat rate, login window).

---

## Table of Contents

- [Performance & Animations](#performance--animations)
- [General UI/UX](#general-uiux)
- [Keyboard & Input](#keyboard--input)
- [Screen & Display](#screen--display)
- [Finder](#finder)
- [Dock & Mission Control](#dock--mission-control)
- [Energy & Sleep](#energy--sleep)
- [Developer Tools](#developer-tools)
- [Spotlight](#spotlight)
- [Security](#security)
- [App Store & Updates](#app-store--updates)
- [Activity Monitor](#activity-monitor)
- [Misc Apps](#misc-apps)

---

## Performance & Animations

Removes UI animations that add perceived latency with no functional benefit.

| Setting | Value | Effect |
|---|---|---|
| `NSWindowResizeTime` | `0.001` | Near-instant window resize animation |
| `NSUseAnimatedFocusRing` | `false` | No focus ring pulse animation |
| `NSToolbarTitleViewRolloverDelay` | `0` | Instant toolbar title on hover |
| `NSAutomaticWindowAnimationsEnabled` | `false` | No open/close window animations |
| `NSScrollAnimationEnabled` | `false` | No sheet slide-down animation |
| `finder DisableAllAnimations` | `true` | No Finder window or Get Info animations |
| `dock autohide-delay` | `0` | Dock appears instantly on hover |
| `dock autohide-time-modifier` | `0` | Dock hides instantly |
| `dock launchanim` | `false` | No app bounce on launch |
| `dock expose-animation-duration` | `0.1` | Faster Mission Control animation |

---

## General UI/UX

| Setting | Value | Effect |
|---|---|---|
| `NSTableViewDefaultSizeMode` | `2` | Medium sidebar icon size |
| `NSNavPanelExpandedStateForSaveMode` | `true` | Save panel always expanded (shows full path) |
| `PMPrintingExpandedStateForPrint` | `true` | Print panel always expanded |
| `NSDocumentSaveNewDocumentsToCloud` | `false` | New files save to disk, not iCloud |
| `NSQuitAlwaysKeepsWindows` | `false` | Don't reopen windows when relaunching apps |
| `NSDisableAutomaticTermination` | `true` | Background apps stay alive (no silent kills) |
| `LSQuarantine` | `false` | No "are you sure?" dialog for downloaded apps |
| `NSAutomaticCapitalizationEnabled` | `false` | No auto-capitalization |
| `NSAutomaticDashSubstitutionEnabled` | `false` | No smart dashes (`--` stays `--`) |
| `NSAutomaticPeriodSubstitutionEnabled` | `false` | No double-space → period |
| `NSAutomaticQuoteSubstitutionEnabled` | `false` | No curly quotes (`"` stays `"`) |
| `NSAutomaticSpellingCorrectionEnabled` | `false` | No auto-correct |
| `NSAutomaticTextCompletionEnabled` | `false` | No inline text completion |

> All text substitutions are disabled — essential for typing code, commands, and config values correctly.

---

## Keyboard & Input

| Setting | Value | Effect |
|---|---|---|
| `KeyRepeat` | `1` | Fastest key repeat rate |
| `InitialKeyRepeat` | `10` | Short delay before repeat starts |
| `ApplePressAndHoldEnabled` | `false` | Key hold repeats instead of showing accent picker |
| `AppleKeyboardUIMode` | `3` | Tab navigates all UI controls (not just text fields) |
| `Trackpad Clicking` | `true` | Tap to click (built-in + Bluetooth trackpad) |
| `TrackpadThreeFingerDrag` | `true` | Drag windows with three fingers |
| `TrackpadCornerSecondaryClick` | `2` | Bottom-right corner = right-click |
| `TrackpadFourFingerHorizSwipeGesture` | `2` | Four-finger swipe between Spaces |
| `TrackpadFourFingerVertSwipeGesture` | `2` | Four-finger swipe for Mission Control/Exposé |
| `TrackpadThreeFingerHorizSwipeGesture` | `1` | Three-finger swipe between full-screen apps |
| `closeViewScrollWheelToggle` | `true` | Ctrl+scroll to zoom |

> `KeyRepeat 1` + `InitialKeyRepeat 10` gives the fastest stable repeat — crucial for Vim navigation and terminal usage. Requires logout to take effect.

---

## Screen & Display

| Setting | Value | Effect |
|---|---|---|
| `askForPassword` | `1` | Require password immediately after sleep |
| `askForPasswordDelay` | `0` | No grace period |
| `screencapture location` | `~/Desktop` | Screenshots saved to Desktop |
| `screencapture type` | `png` | PNG format |
| `screencapture disable-shadow` | `true` | No drop shadow on window screenshots |
| `screencapture include-date` | `true` | Timestamp in screenshot filename |
| `AppleFontSmoothing` | `1` | Light font smoothing for non-Apple displays |

---

## Finder

Configured as a power-user file browser with maximum information visibility.

| Setting | Value | Effect |
|---|---|---|
| `QuitMenuItem` | `true` | Can quit Finder with ⌘Q |
| `DisableAllAnimations` | `true` | No window animations |
| `NewWindowTarget` | `PfHm` | New windows open to home folder |
| `AppleShowAllFiles` | `true` | Show hidden files (dotfiles, `.env`, `.git`) |
| `AppleShowAllExtensions` | `true` | Always show file extensions |
| `ShowStatusBar` | `true` | Item count and disk space at the bottom |
| `ShowPathbar` | `true` | Breadcrumb path bar at the bottom |
| `_FXShowPosixPathInTitle` | `true` | Full POSIX path in the window title |
| `_FXSortFoldersFirst` | `true` | Folders on top in windows |
| `_FXSortFoldersFirstOnDesktop` | `true` | Folders on top on the Desktop |
| `FXDefaultSearchScope` | `SCcf` | Search current folder by default |
| `FXEnableExtensionChangeWarning` | `false` | No warning when changing file extension |
| `WarnOnEmptyTrash` | `false` | No warning before emptying Trash |
| `com.apple.springing.enabled` | `true` | Drag over folder to spring-open it |
| `com.apple.springing.delay` | `0` | Instant spring-load |
| `DSDontWriteNetworkStores` | `true` | No `.DS_Store` on network volumes |
| `DSDontWriteUSBStores` | `true` | No `.DS_Store` on USB volumes |
| `FXPreferredViewStyle` | `Nlsv` | List view by default |
| `~/Library` | `nohidden` | `~/Library` always visible |
| `/Volumes` | `nohidden` | `/Volumes` always visible |

---

## Dock & Mission Control

Dock is kept minimal. Use Spotlight or a launcher (Raycast/Alfred) to open apps.

| Setting | Value | Effect |
|---|---|---|
| `autohide` | `true` | Auto-hide the Dock |
| `static-only` | `true` | Only show open apps (no pinned apps) |
| `show-recents` | `false` | Hide recent apps section |
| `tilesize` | `36` | Small icons |
| `mineffect` | `scale` | Scale minimize (faster than genie) |
| `minimize-to-application` | `true` | Minimize into app icon |
| `show-process-indicators` | `true` | Dots under open apps |
| `showhidden` | `true` | Hidden app icons are translucent |
| `mouse-over-hilite-stack` | `true` | Highlight stack items on hover |
| `mru-spaces` | `false` | Don't auto-rearrange Spaces |
| `expose-group-by-app` | `false` | Flat window layout in Mission Control |

### Hot Corners

| Corner | Action |
|---|---|
| Top-left | Mission Control |
| Top-right | Lock Screen |
| Bottom-left | Desktop (show all) |
| Bottom-right | Sleep Display |

---

## Energy & Sleep

Tuned to avoid interruptions during long-running developer tasks (builds, CI, SSH).

| Setting | Scope | Value | Effect |
|---|---|---|---|
| `lidwake` | all | `1` | Wake on lid open |
| `autorestart` | all | `1` | Auto-restart after power loss |
| `sleep` | charger | `0` | Never sleep while charging |
| `disksleep` | charger | `0` | Disk stays awake while charging |
| `displaysleep` | charger | `20 min` | Display sleeps after 20 min on charger |
| `displaysleep` | battery | `10 min` | Display sleeps after 10 min on battery |
| `sleep` | battery | `15 min` | Machine sleeps after 15 min on battery |
| `standbydelay` | all | `86400` (24h) | 24-hour delay before entering deep standby |
| `powernap` | battery | `0` | No background activity on battery |
| `powernap` | charger | `1` | Background updates allowed on charger |

---

## Developer Tools

| Setting | Value | Effect |
|---|---|---|
| `~/Developer` | created | Standard dev folder for Xcode/projects |
| `CrashReporter DialogType` | `notification` | Crash reports as banners, not blocking dialogs |
| `TextEdit RichText` | `0` | Plain text mode by default |
| `TextEdit PlainTextEncoding` | `4` (UTF-8) | UTF-8 for open and save |
| `Terminal StringEncodings` | `4` (UTF-8) | UTF-8 only in Terminal |
| `Terminal SecureKeyboardEntry` | `true` | Protects keystrokes from other processes |
| `Terminal ShowLineMarks` | `0` | No shell line markers |
| `Safari ShowFullURLInSmartSearchField` | `true` | Full URL always visible |
| `Safari IncludeDevelopMenu` | `true` | Develop menu enabled |
| `Safari WebKit2DeveloperExtrasEnabled` | `true` | Web Inspector available |
| `Safari WebKitDeveloperExtras` | `true` | Right-click "Inspect Element" in any WebView |
| `Safari AutoOpenSafeDownloads` | `false` | Don't auto-open downloads |
| `Safari UniversalSearchEnabled` | `false` | No search queries sent to Apple |
| `Safari AutoFill*` | `false` | All AutoFill disabled (use a password manager) |
| `QuickTimePlayerX MGPlayMovieOnOpen` | `true` | Auto-play on open |

---

## Spotlight

Only developer-relevant categories are enabled to reduce noise and improve result speed.

| Category | Enabled |
|---|---|
| Applications | ✅ |
| System Preferences | ✅ |
| Directories | ✅ |
| Documents | ✅ |
| PDF | ✅ |
| Source Code | ✅ |
| Fonts | ❌ |
| Contacts | ❌ |
| Calendar & Reminders | ❌ |
| Images | ❌ |
| Bookmarks | ❌ |
| Music | ❌ |
| Movies | ❌ |
| Presentations | ❌ |
| Spreadsheets | ❌ |
| Messages | ❌ |
| Web / Spotlight Suggestions | ❌ |

The script also rebuilds the Spotlight index (`mdutil -E /`) after applying these settings.

---

## Security

| Setting | Value | Effect |
|---|---|---|
| `askForPassword` | `1` | Password required immediately after sleep |
| `askForPasswordDelay` | `0` | No grace period |
| `loginwindow SHOWFULLNAME` | `true` | Login shows username + password fields (not user list) |
| `LSQuarantine` | `false` | No Gatekeeper warning for downloaded apps |

> To re-enable the Gatekeeper dialog: `defaults write com.apple.LaunchServices LSQuarantine -bool true`

---

## App Store & Updates

| Setting | Value | Effect |
|---|---|---|
| `AutomaticCheckEnabled` | `true` | Check for updates automatically |
| `ScheduleFrequency` | `1` | Check daily |
| `AutomaticDownload` | `1` | Download updates in the background |
| `CriticalUpdateInstall` | `1` | Auto-install security and system data updates |
| `commerce AutoUpdate` | `true` | Auto-update App Store apps |

---

## Activity Monitor

| Setting | Value | Effect |
|---|---|---|
| `OpenMainWindow` | `true` | Opens main window on launch |
| `IconType` | `5` | CPU history graph in Dock icon |
| `ShowCategory` | `0` | Show all processes |
| `SortColumn` | `CPUUsage` | Sort by CPU by default |
| `SortDirection` | `0` | Descending (highest first) |

---

## Misc Apps

### Photos

| Setting | Value | Effect |
|---|---|---|
| `disableHotPlug` | `true` | Don't open Photos when a device is plugged in |

### Time Machine

| Setting | Value | Effect |
|---|---|---|
| `DoNotOfferNewDisksForBackup` | `true` | Don't prompt to use new disks as backup volumes |

### Mail

| Setting | Value | Effect |
|---|---|---|
| `DisableReplyAnimations` | `true` | No reply animation |
| `DisableSendAnimations` | `true` | No send animation |
| `AddressesIncludeNameOnPasteboard` | `false` | Copy `foo@example.com` not `Foo Bar <foo@example.com>` |
| `DisableInlineAttachmentViewing` | `true` | Show attachment icons, not inline previews |
| `SpellCheckingBehavior` | `NoSpellCheckingEnabled` | No spell check in Mail |

### Messages

| Setting | Value | Effect |
|---|---|---|
| `automaticQuoteSubstitutionEnabled` | `false` | No curly quotes (useful for code snippets) |
| `continuousSpellCheckingEnabled` | `false` | No spell check |
