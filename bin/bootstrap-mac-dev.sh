#!/usr/bin/env bash

declare GIT_REPO_PARENT_DIR=${HOME}/workspace/git/github.com/drgeb
declare GIT_REPO_DIR=${GIT_REPO_PARENT_DIR}/mac-dev-playbook
declare REPO_URL=https://github.com/drgeb/mac-dev-playbook.git

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
    brew install sqlite
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


if [ ! -d ${GIT_REPO_PARENT_DIR} ]; then
    mkdir -pv ${GIT_REPO_PARENT_DIR}
fi

if [ -f ~/.ssh/known_hosts ]; then
  IS_HOST_DEFINED=`grep bitbucket.org ~/.ssh/known_hosts`
  if [ "${IS_HOST_DEFINED}" != "" ]; then
    ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts
  fi

  IS_HOST_DEFINED=`grep github.com ~/.ssh/known_hosts`
  if [ "${IS_HOST_DEFINED}" != "" ]; then
    ssh-keyscan -H githuub.com >> ~/.ssh/known_hosts
  fi
fi

if [ ! -d ${GIT_REPO_DIR} ]; then
        echo Installing requirements
        cd ${GIT_REPO_DIR} || exit
        git clone ${REPO_URL} system_config
        cd system_config || exit
        ansible-galaxy role install -r requirements.yml
        ansible-galaxy collection install -r requirements.yml
fi

if [ ! -d ${HOME}/logs ]; then
    mkdir ${HOME}/logs
fi

#ansible-pull -U ${REPO_URL} -i wsl --vault-password-file ~/.ssh/.ansible_vault_system_configs | tee ${HOME}/logs/bootstrap.log
