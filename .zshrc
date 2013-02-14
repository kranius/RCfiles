# Path to your oh-my-zsh configuration.
ZSH=$HOME/repos/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git deb debian)

source $ZSH/oh-my-zsh.sh

setopt nohup
setopt nocheckjobs

setopt appendhistory
setopt print_exit_value
setopt nullglob
setopt chase_links
setopt hist_verify
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt extendedglob
setopt correctall

unsetopt beep
unsetopt hist_beep
unsetopt list_beep
unsetopt rm_star_silent
unsetopt list_ambiguous
unsetopt glob_dots

# Customize to your needs...
#
# Alias :

alias ls='ls -BFGX --color=auto --group-directories-first'
alias rm='rm -R -i'
alias ll='ls -il'
alias la='ls -ila'
alias lla='ls -la'
alias l='ll'
alias less='less -q'
alias df='df -h'
alias du='du -h'
alias grep='grep --color=auto'
alias make='cd .. && cd - && \make'
alias makectags="ctags -R --extra=+q"
alias nh='nethack -ibm | konwert cp437-utf8'
alias slash='slashem -ibm | konwert cp437-utf8'
alias lock='xscreensaver-command -lock'
alias ne='emacs -nw'
alias sup='nice -n 20 svn up'
alias xcl='xclip -sel clip'

#tools
alias eclipse='/home/kranius/eclipse/eclipse'
alias ecl='eclipse'
alias osql='/home/kranius/sqldeveloper/sqldeveloper.sh'
alias st2='/home/kranius/Downloads/st2/sublime_text'
alias ged='st2'


# DGP aliases
alias ci='mvn clean install -Dmaven.test.skip=true -DdownloadSources=true -Pparis'
alias cit='mvn clean install -Dmaven.test.skip=false -DdownloadSources=true -Pparis'
alias jstart='export MAVEN_OPTS="-Xmx768m -XX:MaxPermSize=256M -XX:+UseCompressedOops -Xdebug -Xnoagent -Djava.compiler=NONE -Djna.nosys=true -Xrunjdwp:transport=dt_socket,address=4000,server=y,suspend=n"; cd /home/kranius/repos/antho/clients/webapps; mvn -Dmaven.test.skip=true -Pparis,jetty -DhostName=gdaniel jetty:run -Djetty.port=8081 -Djetty.stop.port=7081 -Djetty.stop.key=STOP -Dmgnt.cluster.node.id=12 -up -Djboss.server.log.dir=/home/kranius/dsc/workspace/'
alias eci='mvn eclipse:clean eclipse:eclipse -Dmaven.test.skip=true
-DdownloadSources=true -Pparis'


[[ -s "/home/kranius/.rvm/scripts/rvm" ]] && source "/home/kranius/.rvm/"

serve() {
  python3 -m http.server ${1:-8000}
}

# Exports
#

export no_proxy=localhost,127.0.0.1

export EDITOR=/usr/bin/vim
export TERM=rxvt-256color
export NNTPSERVER="reader.albasani.net"

export JAVA_HOME=/home/kranius/jdk6
export M2_REPO=/home/kranius/.m2/repository
export MAVEN_OPTS='-Xrunjdwp:transport=dt_socket,address=4000,server=y,suspend=n'

export PATH="$JAVA_HOME/bin:$PATH:$HOME/.cabal/bin"

export ORACLE_BASE=/usr/lib/oracle/11.2
export ORACLE_HOME=$ORACLE_BASE/client64
export PATH=$PATH:$ORACLE_HOME/bin
export TNS_ADMIN=/etc/oracle
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/include/oracle/11.2/client64:/usr/lib/oracle/11.2/client64/lib


export PATH="$PATH:$HOME/.rvm/bin"
