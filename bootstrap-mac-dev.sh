#!/usr/bin/env bash

# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# Install the Command Line Tools
set +e
xcode-select -p
RETVAL=$?
set -e
if [[ "$RETVAL" -ne "0" ]]; then
    echo "Installing XCode Command Line Tools"
    xcode-select --install
    read -p "Continue? [Enter]"
fi

# Install brew
if [[ ! -x "/usr/local/bin/brew" ]]; then
    echo "Installing brew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# This homebrew/dupes is deprecated
# brew tap homebrew/dupes
brew tap aws/tap
brew tap bramstein/webfonttools
brew tap caryll/tap
brew tap cloudfoundry/tap
brew tap d12frosted/emacs-plus
brew tap goreleaser/tap
brew tap jenkins-x/jx
brew tap pivotal/tap
brew tap weaveworks/tap
brew tap webhookrelay/tap
brew tap yschimke/tap

# Install sqllite
if [[ ! -d "/usr/local/Cellar/sqlite" ]]; then
    echo "Installing sqlite"
    brew install sqlite --with-function --with-secure-delete
fi

# Install Tcl/Tk
# if [[ ! -d "/usr/local/Cellar/tcl-tk" ]]; then
#    echo "Installing tcl-tk"
#    brew install tcl-tk --with-threads
#fi

# Install Python 2
#if [[ ! -d "/usr/local/Cellar/python" ]]; then
#    echo "Installing python 2"
#    brew install python --with-berkeley-db4
#fi

# Install Python 3
if [[ ! -d "/usr/local/Cellar/python@3.9" ]]; then
    echo "Installing python 3"
    brew install python3

fi

# Update Pip2 packages
# /usr/local/bin/pip2 install -U pip setuptools wheel
echo "Upgrade pip, setuptools and wheel packages"
/usr/local/bin/pip3 install -U pip setuptools wheel


# Install Ansible
if [[ ! -x "/usr/local/bin/ansible" ]]; then
    echo "Installing ansible"
    /usr/local/bin/pip3 install ansible kerberos pywinrm
fi