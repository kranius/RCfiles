ZSH=$HOME/.oh-my-zsh
ZSH_THEME="muse"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi


plugins=(git macos docker kubectl nmap)
#fpath=(/usr/local/share/zsh-completions $fpath)

setopt nohup
setopt nocheckjobs

setopt appendhistory
setopt print_exit_value
setopt nullglob
setopt chase_links
setopt hist_verify
#setopt auto_cd
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


alias v='nvim'
alias vs="v ~/.zshrc"
alias vv="v ~/.vimrc"
alias vn="v ~/.config/nvim/init.vim"

alias kek='cat ~/kek.meme'
alias rm='rm -R -i'
#need GNU ls for -X and long options
alias mls='gls -BFX --color=auto --group-directories-first'
alias ls='mls'
alias ll='mls -l'
alias la='mls -la'
alias lla='mls -ila'
alias l='ll'
alias less='less -q'
alias df='df -h'
alias du='du -h'
#need GNU grep for long options
alias grep='grep --color=auto'
alias make='cd .. && cd - && \make'
alias makectags="ctags -R --extra=+q"
alias lock='xscreensaver-command -lock'
alias ne='emacs -nw'
alias xcl='xclip -sel clip'

alias hr='stack ghci'
alias hs='stack test --fast --haddock-deps --file-watch --ghc-options="-Wall -Wcompat -Wincomplete-record-updates -Wincomplete-uni-patterns -Wredundant-constraints"'
alias hb='stack test --haddock-deps --ghc-options="-Werror -Wall -Wcompat -Wincomplete-record-updates -Wincomplete-uni-patterns -Wredundant-constraints"'
alias hd='stack haddock --open'
alias hh='stack hoogle -- generate --local'
alias hw='stack hoogle -- server --local --port=8080'
alias ht='stack build --copy-compiler-tool'

mikrotik-fw-logIP() {
  readonly logfile=${1:?"Must specify log file !"}
  awk -F "," '{print $5}' $logfile | awk -F "->" '{print $1}' | sort
}

serve() {
  python3 -m http.server ${1:-8000}
}

export no_proxy=localhost,127.0.0.1

export EDITOR=/usr/bin/vim
export TERM=xterm-256color
export NNTPSERVER="reader.albasani.net"

export LANG="en_US.utf-8"
export PATH="$HOME/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source <(kubectl completion zsh)

source $ZSH/oh-my-zsh.sh
#source ~/.zshrc

