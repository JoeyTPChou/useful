if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi


PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;32m\]\w\[\033[00m\]\$ '
##PATH="/usr/local/bin:${PATH}"
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/Cellar/

export CLICOLOR=1
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"
