#!/bin/bash

ansible-playbook /etc/ansible/filebeat-playbook.yml
sleep 5
ansible-playbook /etc/ansible/metricbeat-playbook.yml