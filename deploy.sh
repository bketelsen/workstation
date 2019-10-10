#!/bin/bash

APULL=$(which ansible-pull)
MYREPO="https://github.com/bketelsen/workstation.git"
MYPPA="ansible"

# Bootstrap Ansible
if ! grep -q "$MYPPA" /etc/apt/sources.list.d/*; then
	echo "Ansible Repo not available"
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install git ansible -y
fi

if [ ! -f $HOME/.ansible.cfg ]; then
	touch $HOME/.ansible.cfg
	echo '[defaults]' >$HOME/.ansible.cfg
	echo 'remote_tmp     = /tmp/$USER/ansible' >>$HOME/.ansible.cfg
fi

sudo "$APULL -U $MYREPO"
