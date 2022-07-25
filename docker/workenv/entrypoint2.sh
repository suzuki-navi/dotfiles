sed s/required/sufficient/g -i /etc/pam.d/chsh
chsh --shell /usr/bin/zsh $HOST_USER
