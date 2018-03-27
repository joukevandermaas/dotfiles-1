zstyle :compinstall filename '/home/kitty/.zshrc'

autoload -Uz compinit promptinit

# autocompletion
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# prompt themes
promptinit
prompt walters

# zle vi mode
bindkey -v
# get distro identifier
DISTRO=$(cat /etc/*-release | grep "^NAME" | cut -d= -f2)
if [[ $DISTRO == '"Arch Linux"' ]]; then
  # source pkgfile for archlinux for suggestions on
  # where to find missing binaries
  if [[ -d /usr/share/doc/pkgfile ]] then
    source /usr/share/doc/pkgfile/command-not-found.zsh;
  fi
  # fix view linking to ex
  # TODO: add check for vim being installed
  alias view="vim -R"
fi

# general useful aliases
alias pubip="wget http://ipinfo.io/ip -qO -" 
alias gitdir="cd /home/$USER/Documents/Git/"
alias vpnup="sudo systemctl start openvpn-client@client"
alias vpndown="sudo systemctl stop openvpn-client@client"
alias cclip="xclip -selection clipboard"
alias clipp="xclip -selection clipboard -o"
alias weather="curl wttr.in"
alias download="curl -O -L -C -"
alias inforet="gitdir; cd fraudprotection/inforetrieve; jupyter notebook"
alias badhorse="traceroute bad.horse"
alias telnetwars="telnet towel.blinkenlights.nl"
alias cryptorate="curl rate.sx"

# hosts
# kitty.sh -> nyaa-proxy
# dynip -> nyaa-core nyaa-gate
alias kitty.sh="ssh kitty@kitty.sh"
alias kitty.sh-reverse="ssh -R 2222:localhost:22 -N kitty@kitty.sh"

alias session="tmux new -As "

# alias backdir="cd /run/media/alev/WesternDrive/backup/ArchRsyncApril21/home/alev"

# Should I be using git aliases for this?
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"

# go through all folders in $gitdir and fetch + status
function gitdircheck {
  returndir=`pwd`
  gitdir;
  for dir in */; do
    cd $dir;
    printf '%48s\n' | tr ' ' -;
    echo $dir;
    git fetch;
    git status;
    cd ..;
  done
  cd $returndir
}

function gitdirpull {
  returndir=`pwd`
  gitdir;
  for dir in */; do
    cd $dir;
    printf '%48s\n' | tr ' ' -;
    echo $dir;
    git pull;
    cd ..;
  done
  cd $returndir
}

function gitdirclean {
  returndir=`pwd`
  gitdir;
  for dir in */; do
    cd $dir;
    printf '%48s\n' | tr ' ' -;
    echo $dir;
    git clean -xi;
    cd ..;
  done
  cd $returndir
}

function git-ssh {
  eval $(ssh-agent)
  ssh-add ~/.ssh/id_rsa_github
}


# history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt autocd extendedglob nomatch

# beep is bad, and you should feel bad
unsetopt beep

# added by travis gem
[ -f /home/kitty/.travis/travis.sh ] && source /home/kitty/.travis/travis.sh
