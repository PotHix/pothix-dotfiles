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

# z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

pathadd $HOME/bin               # my personal scripts
pathadd $HOME/.cargo/bin        # rust binaries
pathadd $HOME/go/bin            # golang binaries
pathadd $HOME/.npm-global/bin   # javascript/npm binaries

# Start starship
eval "$(starship init bash)"
