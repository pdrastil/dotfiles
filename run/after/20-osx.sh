#!/bin/sh
source ../lib/setup.sh
set -o errexit -o nounset

title "Screensaver"
# Start screensaver after 10 minutes
defaults -currentHost write com.apple.screensaver idleTime 600
# Set screensaver to Drift
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName Drift path /System/Library/Screen\ Savers/Drift.saver type 0

title "Dock items"
dockutil --remove all --no-restart
dockutil --add "/Applications/ForkLift.app" --no-restart
dockutil --add "/Applications/Safari.app" --no-restart
dockutil --add "/Applications/Google Chrome.app" --no-restart
dockutil --add "/System/Applications/Notes.app" --no-restart
dockutil --add "/Applications/Visual Studio Code.app" --no-restart
dockutil --add "/Applications/GitKraken.app" --no-restart
dockutil --add "/Applications/iTerm.app" --no-restart
dockutil --add "/Applications/Slack.app" --no-restart
dockutil --add "/Applications/Microsoft Outlook.app" --no-restart
dockutil --add "/Applications/Authy Desktop.app" --no-restart
dockutil --add "/System/Applications/System Preferences.app" --no-restart
dockutil --add "~/Downloads" --display folder --all-homes --no-restart

title "Restart OSX applications"
for app in Finder Dock SystemUIServer; do
  subtitle "$app"
  killall "$app" >/dev/null 2>&1
done
