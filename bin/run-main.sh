#!/bin/sh

ansible-playbook main.yml --ask-become-pass | tee ~/logs/ansible-playbook.log
