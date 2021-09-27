#!/bin/bash

ansible all -m ping
sleep 5
ansible-playbook /etc/ansible/install-elk.yml