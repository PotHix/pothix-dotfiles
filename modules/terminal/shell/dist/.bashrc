########################################
# EXPORTING ENVIRONMENT VARIABLES
########################################

export CDPATH=.:~:$HOME/repos:$HOME/go/src
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

export HISTCONTROL=ignoredups  # don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth  # ... and ignore same sucessive entries.
export HISTFILESIZE=5000

export EDITOR=vim
export GEM_EDITOR=vim
export GIT_EDITOR=vim

export GITHUB_USER=pothix
export CODES=$HOME/repos

export GPG_TTY=$(/usr/bin/tty)

export LANG=en_US.UTF-8

# when building kernels from AUR
export MAKEFLAGS=-$(nproc)

if [ -f /bin/urxvt ]; then
    export TERM=rxvt
fi

########################################
# USING COMPLETION AND ALIAS
########################################
source $HOME/.bash_aliases

# loads GitHub CLI completion
if [[ "$(command -v gh)" != "" ]]
then
    eval "$(gh completion -s bash)"
fi

# loads fzf completion
if [[ "$(command -v fzf)" != "" ]]
then
    source /usr/share/fzf/key-bindings.bash
    source /usr/share/fzf/completion.bash
fi

########################################
# Random helpers
########################################

v (){
    local editor="vi"

    if [[ "$(command -v vim)" != "" ]]
    then
        editor="vim"
    fi

    if [[ "$(command -v nvim)" != "" ]]
    then
        editor="nvim"
    fi

    # Removing : from a file name and adding + to go to the especified line
    local file=$(echo $1 | sed -r 's/:([0-9]+).*/ +\1/')
    eval "$editor $file"
}

goodpractices (){
    local extensions_regex=".*\.\(py\|j\|c\|rb\|js\|php\)$"

    # Removing trailing spaces
    find * -type f -regex $extensions_regex | xargs sed -i 's/\s\+$//g'

    # Adding a newline to the end of the file if needed
    for i in `find * -type f -regex $extensions_regex`; do
        if [ "`tail -c 1 $i`" != "" ]; then echo >> $i; fi

        for k in $@; do
            git checkout $k
        done
    done
}

iconver (){
    for i in `find . | egrep "\.(css|html|js)"`; do iconv -f iso-8859-1 -t utf8 $i > $i.utf; done
    for i in `find . | grep utf`; do cp $i ${i%%.utf}; rm $i; done
}

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

########################################
# fzf helpers
########################################

# Install one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to install
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [I]nstall
vmi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list-all $lang | tail -r | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do asdf install $lang $version; done;
    fi
  fi
}

# Remove one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to remove
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [C]lean
vmc() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list $lang | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do asdf uninstall $lang $version; done;
    fi
  fi
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}


########################################
# Language specific paths
########################################

# asdf-vm
source /opt/asdf-vm/asdf.sh

pathadd $HOME/bin               # my personal scripts
pathadd $HOME/.cargo/bin        # rust binaries
pathadd $HOME/go/bin            # golang binaries
pathadd $HOME/.npm-global/bin   # javascript/npm binaries

# Start starship
eval "$(starship init bash)"
