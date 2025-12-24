# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git asdf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
##############################################
#    Helper Commands
##############################################
alias reload='source $HOME/.zshrc 1>/dev/null'
alias n='navi --best-match --query '
alias np='navi --print --best-match --query '

# To fix allacrity problems with terminfo
alias ssh='TERM=xterm-256color ssh'

alias tokens="bw get item c0ee93da-6a7f-4177-af0a-ae1e00eb12ed | jq -r '.notes'"



##############################################
#    Git
##############################################

alias g='git'
alias ga='git add -A'
alias gb='git branch'
alias gd='git diff'
alias gu='git push origin HEAD'
alias gi='git commit'
alias gl='git log'
alias gp='git pull -p --rebase'
alias gs='git status --untracked-files'
alias gt='git tag'
alias gco='git checkout'
alias gls='git log --stat'
alias glp='git log -p'


##############################################
#    Better default commands powered by Rust
##############################################
alias cat="bat --paging=never --style=plain"
alias z="zeditor ."


##############################################
#    Typos
##############################################

alias vmi='v'
alias ivm='v'
alias cim='v'
alias bim='v'


cdpath=(~/repos)

# asdf-vm
export PATH="$HOME/go/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/pothix/.lmstudio/bin"
# End of LM Studio CLI section

# ide tools completion
. ~/repos/ide-tools/ide/completion/ide-complete.zsh

# MySQL config from https://stackoverflow.com/a/78159078
export MYSQL_HOME=/usr/local/mysql-9.3.0-macos15-arm64/include
export MYSQLCLIENT_CFLAGS="-I/usr/local/mysql-9.3.0-macos15-arm64/include"
export MYSQLCLIENT_LDFLAGS="-L/usr/local/mysql-9.3.0-macos15-arm64/lib -lmysqlclient"

export GOBIN=~/go/bin
# llmcli
# export LLMCLI_MODEL=us.amazon.nova-micro-v1:0
export LLMCLI_MODEL=global.anthropic.claude-haiku-4-5-20251001-v1:0
# Requires specific configuration
# export LLMCLI_MODEL=openai.gpt-oss-20b-1:0

export AWS_PROFILE=BackendPermissionSet-011833101604


########################################
# Random helpers
########################################

v() {
  local editor="vi"

  if [[ "$(command -v nvim)" != "" ]]; then
    editor="nvim"
  elif [[ "$(command -v lvim)" != "" ]]; then
    editor="lvim"
  elif [[ "$(command -v vim)" != "" ]]; then
    editor="vim"
  fi

  # Removing : from a file name and adding + to go to the especified line
  local file
  file=$(echo "$1" | sed -r 's/:([0-9]+).*/ +\1/')
  eval "$editor -O $file"
}

create_pr() {
  local reviewer=$1

  if [ "$reviewer" != "" ]; then
    gh pr create -f -a $GITHUB_USER -r "$reviewer"
  else
    gh pr create -f -a $GITHUB_USER
  fi
}
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
source $HOME/.cargo/env
