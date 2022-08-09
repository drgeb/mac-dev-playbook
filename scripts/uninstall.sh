#!/bin/sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
rm /opt/homebrew/SECURITY.md
rm -rf /opt/homebrew/etc/
rm -rf /opt/homebrew/share/
rm -rf /opt/homebrew/var/
