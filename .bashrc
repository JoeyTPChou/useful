# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=""
export HISTFILESIZE=""

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export GIT_EDITOR=vim

alias vi='vim'
alias gs='git status'
alias gsn='git status -uno'
alias gd='git diff'
alias gb='git branch'
alias gl='git log'
open() {
  gvfs-open $1 &
}
PATH="/home/boton/srilm-1.5.10/bin/i686-m64:$PATH"
export PATH=/usr/local/cuda/bin:$PATH
alias gitka='gitk --all &'
#alias rm='trash-rm'
#alias fg='vim -c "normal '\''0"'
alias diff='colordiff'
alias m='make'
alias f='fg'
alias b='cd TFAM_OfficialApp/backend/'
alias v='vim'
PS1=$'\\[\e[32m\\]\W\\[\e[0m\\]@\h \\[\e[34m\\]>> \\[\e[0m\\]'

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
CPATH=/usr/local/boost_1_53_0/:/usr/local/boton/include/:$CPATH
C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/boton/include/:/usr/local/hdf5/include/
CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/hdf5/include/
CPATH=$CPATH:/usr/local/hdf5/include/:/usr/local/cuda/include
export CUDA_HOME=/usr/local/cuda
export LANG=en_US.UTF-8

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib32:/usr/lib
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/:/usr/local/cuda/lib64/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/atlas/lib/:/usr/local/hdf5/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/boton/Local/pcl/build/lib

export LIBRARY_PATH=/usr/local/cuda/lib64:$LIBRARY_PATH

stty -echoctl

# OpenCV
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH

# Turn on/off the backlight LED of keyboard
led() {
  if [ "$1" == "on" ]; then
    xset led 3 && touch /tmp/keyboard_light
  elif [ "$1" == "off" ]; then
    xset -led 3 && rm -f /tmp/keyboard_light
  else
    echo "Usage: led on/off"
  fi
}

setgpu() {
  if [ "$1" == "TitanX" ]; then
    local id=0
  elif [ "$1" == "980Ti" ]; then
    local id=1
  elif [ "$1" == "660" ]; then
    local id=2
  else
    echo "Usage: setgpu TitanX/980Ti/660"
    return
  fi
  export CUDA_VISIBLE_DEVICES=$id
}
setgpu TitanX

set_cudnn() {
  if [ "$1" == "4" ]; then
    local cudnn_version=4007
  elif [ "$1" == "5" ]; then
    local cudnn_version=5105
  else
    echo "Usage: set_cudnn 4/5"
    return
  fi
  CUDA_HOME=/usr/local/cuda
  rm $CUDA_HOME/include/cudnn.h
  rm $CUDA_HOME/lib64/libcudnn*
  ln -s /home/boton/Local/cudnn-${cudnn_version}/include/* $CUDA_HOME/include
  ln -s /home/boton/Local/cudnn-${cudnn_version}/lib64/* $CUDA_HOME/lib64/
}
# set_cudnn 5

scpgz() {
  # tar zcvf test.tar.gz -C /home/boton/Test .

  args=(${1//\:/ })
  remote=${args[0]}
  srcdir=${args[1]}
  destdir=$2

  mkdir $destdir && ssh $remote "tar zcf - -C $srcdir ." | tar zxf - -C $destdir
}

export PYTHONPATH=$PYTHONPATH:/home/boton/Local/caffe/python
export PYTHONPATH=$PYTHONPATH:/share/Research/Yamaha/tensorflow_helnet/python
export PYTHONPATH=$PYTHONPATH:/share/Research/dataset/cityscapes/devkits/evaluation
export PYTHONPATH=$PYTHONPATH:/share/Research/dataset/cityscapes/devkits/helpers
export PYTHONPATH=$PYTHONPATH:/share/Research/Yamaha/shadow-augmentation-by-silhouette/python
export PYTHONPATH=$PYTHONPATH:/share/Research/Yamaha/random_obstacle/python
export PYTHONPATH=$PYTHONPATH:/share/Research/Yamaha/img2costmap
export PYTHONPATH=$PYTHONPATH:/home/boton/Local/reinforcement-learning
export PYTHONPATH=$PYTHONPATH:/home/boton/Local/reinforcement-learning/lib
export PYTHONPATH=$PYTHONPATH:/home/boton/Dropbox/CMU/dirl/gym_offroad_nav
export PYTHONPATH=$PYTHONPATH:/home/boton/Dropbox/CMU/dirl/deep-reinforcement-learning
export PYTHONPATH=$PYTHONPATH:/home/boton/Dropbox/CMU/gan/instagram-filters

export VISUAL=vim
export EDITOR=vim
# alias ..="cd .."
# alias ...="cd ../.."
# alias ....="cd ../../.."
# alias .....="cd ../../../.."
# alias ......="cd ../../../../.."
# alias x='screen'
# eval $(thefuck --alias)
alias rosplay='rosbag play -l --clock'
alias gg='./go.sh'
alias dynparam='rosrun dynamic_reconfigure dynparam'
function mygrep() {
  grep "$@" --color=always | sed "s%:\([^:]*[0-9]*[^:]*\):% +\1:%g"
}

alias parfor='/home/boton/Dropbox/DSP/bash_lib/parfor.sh'

# mean() { cat - | python -c 'from sys import stdin; nums = [float(i) for i in stdin.read().split("\n") if i != ""]; print(sum(nums)/len(nums))'; }
range() { cat - | python -c 'from sys import stdin; import numpy as np; nums = np.array([i for i in stdin.read().split("\n") if i != ""], dtype=np.float); print "min = {}, max = {}".format(np.min(nums), np.max(nums))'; }
# export -f mean

# pkldump() { python -c 'import sys; import pickle; sys.displayhook(pickle.load(open(sys.argv[1])))' $1; }
pkldump() { ipython -c "import sys; import pickle; sys.displayhook(pickle.load(open('$1')))"; }
export -f pkldump
alias rm='trash'
alias caffe='/home/boton/Local/caffe/build/tools/caffe'
alias smi='nvidia-smi'

inspect_ckpt() {
  echo $1
  python /home/boton/Local/tensorflow/tensorflow/python/tools/inspect_checkpoint.py --file_name=$1
}

CUDA_VISIBLE_DEVICES="0,1"

# export ROS_MASTER_URI=http://OLIVAW:11311
function xmlcat() {
  cat $@ | xmllint --format - | pygmentize -l xml
}
export MUJOCO_PY_MJKEY_PATH=/home/boton/.mujoco/mjkey.txt
export MUJOCO_PY_MJPRO_PATH=/home/boton/.mujoco/mjpro131

alias monitor='ssh perceptron "cd ~/cdrl/log && /cm/shared/apps/slurm/16.05.2/bin/squeue | grep poweic && ./grep-humanoid.sh 5 && ./grep-double.sh 5 && ./grep-pendulum.sh 5"'

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

vivado_2017 () {
    export PATH=/opt/Xilinx/Vivado/2017.4/bin/:$PATH
    export PATH=/opt/Xilinx/SDx/2017.4/bin/:$PATH
    export PATH=/opt/Xilinx/SDK/2017.4/bin/:$PATH
    export PATH=/opt/Xilinx/SDK/2017.4/gnu/microblaze/lin/bin/:$PATH
}

vivado_2018 () {
    export PATH=/opt/Xilinx-2018/Vivado/2018.1/bin/:$PATH
    export PATH=/opt/Xilinx-2018/SDx/2018.1/bin/:$PATH
    export PATH=/opt/Xilinx-2018/SDK/2018.1/bin/:$PATH
    export PATH=/opt/Xilinx-2018/SDK/2018.1/gnu/microblaze/lin/bin/:$PATH
}

vivado_2017
export PATH=/opt/Xilinx-2018/Vivado/2018.1/bin/:$PATH
export VIVADO_ROOT=/opt/Xilinx/Vivado/2017.4

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/

## Mentor Graphi Catapult:
#export MGC_HOME=/home/fpga/acore/third_party/catapult_lib/
export MGC_HOME=/home/fpga/Catapult/Mentor_Graphics/Catapult_Synthesis_10.2d-784373/Mgc_home
export PATH=$PATH:$MGC_HOME/bin
export LM_LICENSE_FILE=27020@gw
export VCS_HOME=/share/opt/N-2017.12-1/

# source /home/fpga/petalinux-v2017.4/settings.sh

export_bin () {
  if [ "$1" == "" ] || [ "$2" == "" ]; then
    echo "Usage: export_bin <bin> <output-directory>"
    return 0
  fi
  ldd `which $1` | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' $2/
  cp `which $1` $2/
}

eval $(thefuck --alias)

cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}
alias ssh='ssh -Y'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH=$PATH:/home/fpga/ATG/scripts/bash/
