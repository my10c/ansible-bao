#!/usr/bin/env zsh
#
# Copyright (©) 2015 - 2025, © Badassops LLC / Luc Suryo
# All rights reserved.
# ansible
_ansible_dir="/Users/luc/projects/ansible"
_hosts="$_ansible_dir"/inventories/hosts.yml
_my_roles="$_ansible_dir"/roles
_my_playbooks="$_ansible_dir"/playbooks
_my_pass="$_ansible_dir"/.vault/passwd.vault

function apd() {
	if (( $# == 0 )) ; then
		echo "Syntax: ap <playbook> <other options>"
		return 1
	fi
	_playbook=$1
	echo $_playbook | grep yml >/dev/null 2>&1
	if (( $? != 0 )) ; then
		_playbook="$_playbook".yml
	fi
	shift
	_current_pwd=$(pwd)
	(
		cd $_ansible ;
		ANSIBLE_DISPLAY_OK_HOSTS=True \
			/usr/local/bin/ansible-playbook -i "$_hosts" "$_my_playbooks"/"$_playbook" $@ ;
	)
	cd $_current_pwd
}

function ap() {
	if (( $# == 0 )) ; then
		echo "Syntax: ap <playbook> <other options>"
		return 1
	fi
	_playbook=$1
	echo $_playbook | grep yml >/dev/null 2>&1
	if (( $? != 0 )) ; then
		_playbook="$_playbook".yml
	fi
	shift
	_current_pwd=$(pwd)
	(
		cd $_ansible ;
		ANSIBLE_DISPLAY_OK_HOSTS=False \
		/usr/local/bin/ansible-playbook -i "$_hosts" "$_my_playbooks"/"$_playbook" $@ ;
	)
	cd $_current_pwd
}

function as() {
	if (( $# == 0 )) ; then
		echo "Syntax: as <command> <other options>"
		return 1
	fi
	_current_pwd=$(pwd)
	(
		cd $_ansible ;
			/usr/local/bin/ansible -i "$_hosts" -m shell -a $@ ;
	)
	cd $_current_pwd
}

function av() {
	if (( $# != 2 )) ; then
		echo "Syntax: avb <create|edit|encrypt|decrypt> vault-file"
		return 1
	fi
	_current_pwd=$(pwd)
	cd $_ansible
	local _avMode=
	case $1
	in
		create)			[[ -f $2 ]]		&& _avMode="edit"	|| _avMode="create" ;;
		edit|modify)	[[ ! -f $2 ]]	&& _avMode="create"	|| _avMode="edit" ;;
		encrypt)		_avMode="encrypt" ;;
		decrypt)		_avMode="decrypt" ;;
		*)				echo "Syntax: av <create|edit|encrypt|decrypt> vault-file" ;;
	esac
	# password arg = --vault-password-file $_my_pass
	/usr/local/bin/ansible-vault $_avMode $2
	cd $_current_pwd
}

alias ave='av edit'
alias avc='av create'
