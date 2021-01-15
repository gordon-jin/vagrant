#!/bin/bash

yum install -y vim git unzip nc telnet
setenforce 0

fix-etc-hosts() {

	log "Fixing /etc/hosts records"
	sed -r '/127\.0\.1\.1/d; $ a \\n192.168.56.10 web-server \n192.168.56.20 db-server' -i /etc/hosts

}

ssh-keys() {
	
	log "publishing ssh keys so vms can connect each other"
	mkdir -p -m 0700 /root/.ssh

	cp /vagrant/id_rsa /root/.ssh
	cp /vagrant/id_rsa.pub /root/.ssh/authorized_keys

	cat << EOF > /root/.ssh/config
Host web-server db-server 192.168.56.*
	StrictHostKeyChecking no

EOF

	chmod 0600 /root/.ssh/*

}

ssh-password() {

	log "Enabling ssh using password and disable DNS reverse lookup"
	sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config

	log "Restarting sshd service"
	service sshd restart 2>&1 | tee -a /tmp/bootstrap.log

}

disable_selinux() {

	log "Set SELinux to permissive mode"
	setenforce 0

	log "Disabling SELinux"
	sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

}

fix-etc-hosts

log "Enabling sshd password authentication"
ssh-keys

log "Enabling sshd password authentication"
ssh-password

disable_selinux

# Setting password for root
log "#####################################"
log "#                                   #"
log "#  Setting root password to oracle123  #"
log "#                                   #"
log "#####################################"
echo "oracle123" | passwd --stdin root



