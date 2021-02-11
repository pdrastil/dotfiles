#!/bin/sh
source ../lib/setup.sh
set -o errexit -o nounset

title "Screensaver preferences"
# Start screensaver after 10 minutes
defaults -currentHost write com.apple.screensaver idleTime 600
# Set screensaver to Drift
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName Drift path /System/Library/Screen\ Savers/Drift.saver type 0

title "Restart system applications"
for app in Finder Dock SystemUIServer; do
  subtitle "$app"
  killall "$app" >/dev/null 2>&1
done
