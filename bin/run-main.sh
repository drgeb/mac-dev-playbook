#!/bin/sh
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

DATE=$(date '+%Y%m%d%H%M%S')

if [ ! -d ${HOME}/logs ]; then
    mkdir ${HOME}/logs
fi

ansible-playbook playbooks/main.yml --ask-become-pass  -vvvvv 2>&1 | tee ~/logs/${DATE}-ansible-playbook.log
