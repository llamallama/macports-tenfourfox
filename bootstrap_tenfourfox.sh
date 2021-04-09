#!/bin/bash

set -euf

macports_version='2.6.4'
macports_installer="/Volumes/MacPorts-${macports_version}/MacPorts-${macports_version}.pkg"
macports_tree_url='http://tenfourports.pipetogrep.org/opt.tar.gz'

read -rp "This will delete your existing Macports installation! Are you sure? (y/n)? " yn
case "$yn" in
  y|Y )
      ;;
  * )
      echo "Aborting"; exit 0 ;;
esac

# Remove currently macports installation if it exists
if dscl . -list /users | grep -q macports; then
  read -rp "Existing Macports install found! Last chance to abort. Are you sure? (y/n)? " yn
  case "$yn" in
    y|Y )
        ;;
    * )
        echo "Aborting"; exit 0 ;;
  esac

  sudo dscl . -delete /Users/macports
  sudo dscl . -delete /Groups/macports

  sudo rm -rf \
    /opt/local \
    /Applications/DarwinPorts \
    /Applications/MacPorts \
    /Library/LaunchDaemons/org.macports.* \
    /Library/Receipts/DarwinPorts*.pkg \
    /Library/Receipts/MacPorts*.pkg \
    /Library/StartupItems/DarwinPortsStartup \
    /Library/Tcl/darwinports1.0 \
    /Library/Tcl/macports1.0 \
    ~/.macports

  echo "Macports installation deleted"
fi

echo "Downloading and installing Macports $macports_version"

curl -k "https://distfiles.macports.org/MacPorts/MacPorts-${macports_version}-10.4-Tiger.dmg" --output /tmp/macports-tiger.dmg

open /tmp/macports-tiger.dmg

echo "Waiting for DMG to mount"
echo "$macports_installer"

while [[ ! -d "$macports_installer" ]]; do
  sleep 2
done

echo "DMG Mounted. Installing!"

sudo installer -pkg "$macports_installer" -target /

dmg_mount="$(hdiutil info | grep 'macports-tiger' -A15 | tail -n 1 | awk '{print $1}')"

if [[ -n "$dmg_mount" ]]; then
  hdiutil detach "$dmg_mount"
  rm /tmp/macports-tiger.dmg
fi

echo "Macports $macports_version installed. Downloading and installing ports tree"

curl -s "$macports_tree_url" | sudo tar xzvpf - -C /
