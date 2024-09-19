- Here is how I fix lost root control of HOST machine system
pkexec chown root:root /etc/sudoers /etc/sudoers.d -R
sudo apt update
ls -la /etc/sudo.conf 
sudo chown root:root /etc/sudo.conf 