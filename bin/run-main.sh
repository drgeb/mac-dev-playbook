#!/bin/sh
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

DATE=$(date '+%Y%m%d%H%M%S')

ansible-playbook main.yml --ask-become-pass | tee ~/logs/${DATE}-ansible-playbook.log
