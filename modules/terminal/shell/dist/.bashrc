########################################
# EXPORTING ENVIRONMENT VARIABLES
########################################

export CDPATH=.:~:$HOME/repos:$HOME/go/src
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

export HISTCONTROL=ignoredups # don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth # ... and ignore same sucessive entries.
export HISTFILESIZE=5000

export EDITOR=vim
export GEM_EDITOR=vim
export GIT_EDITOR=vim

export GITHUB_USER=pothix
export CODES=$HOME/repos

export GOPRIVATE="github.com/Doist"

export GPG_TTY=$(/usr/bin/tty)

export LANG=en_US.UTF-8

export ANDROID_HOME=$HOME/Android

########################################
# USING COMPLETION AND ALIAS
########################################
source $HOME/.bash_aliases

# loads GitHub CLI completion
if [[ "$(command -v gh)" != "" ]]; then
  eval "$(gh completion -s bash)"
fi

# loads fzf completion
if [[ "$(command -v fzf)" != "" ]]; then
  source /usr/share/fzf/key-bindings.bash
  source /usr/share/fzf/completion.bash
fi

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

iconver() {
  for i in $(find . | grep -E "\.(css|html|js)"); do iconv -f iso-8859-1 -t utf8 "$i" >"$i".utf; done
  for i in $(find . | grep utf); do
    cp "$i" "${i%%.utf}"
    rm "$i"
  done
}

pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

create_pr() {
  local reviewer=$1

  if [ "$reviewer" != "" ]; then
    gh pr create -f -a $GITHUB_USER -r "$reviewer"
  else
    gh pr create -f -a $GITHUB_USER
  fi
}

blogpost() {
  pushd "$CODES/pothix.github.com" || exit
  local post
  post=$(hugo new "$1".md |& sed -r "s@^.*($CODES.*.md).*@\1@g")
  echo "$post"
  lvim "$post"
}

base64-img() {
  local image=$1

  if [ "$image" == "" ]; then
    echo "Please provide the path of the image as an argument"
    return 1
  fi

  magick -size 640x480 "$image" - | base64 -w 0 | xsel -b
}

########################################
# fzf helpers
########################################

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

# cdf - cd into the directory of the selected file
cdf() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir" || exit
}

########################################
# Language specific paths
########################################

# asdf-vm
source /opt/asdf-vm/asdf.sh

# z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

pathadd "$HOME/.local/bin"      # my personal scripts and lvim
pathadd "$HOME/.cargo/bin"      # rust binaries
pathadd "$HOME/go/bin"          # golang binaries
pathadd "$HOME/.npm-global/bin" # javascript/npm binaries

# Start starship
eval "$(starship init bash)"

########################################
# Testing handy functions from Reddit
########################################

# Find out what is taking so much space on your drives
alias diskspace="du -S | sort -n -r | less"

# Easy way to extract archives
extract() {
  if [ -f "$1" ]; then
    case "$1" in
    *.tar.bz2) tar xvjf "$1" ;;
    *.tar.gz) tar xvzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xvf "$1" ;;
    *.tbz2) tar xvjf "$1" ;;
    *.tgz) tar xvzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# Move 'up' so many directories instead of using several cd ../../, etc.
up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }

# List people in a Twitch channel chat
function twitch_list() { curl -s "https://tmi.twitch.tv/group/user/$1/chatters" | jq '.chatters | .moderators,.viewers'; }

# Print a word from a certain column of the output when piping.
# Example: cat /path/to/file.txt | fawk 2 --> Print every 2nd word in each line.
function fawk {
  first="awk '{print "
  last="}'"
  cmd="${first}\$${1}${last}"
  eval $cmd
}

# 'cd' to the most recently modified directory in $PWD
cl() {
  last_dir="$(ls -Frt | grep '/$' | tail -n1)"
  if [ -d "$last_dir" ]; then
    cd "$last_dir"
  fi
}

diskcopy() { dd if=$1 of=$2; }

# Generate a random strong password
alias genpasswd="strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n'; echo"

# Example: translate "Bonjour! Ca va?" en
function translate() { wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$2&dt=t&q=$(echo $1 | sed "s/[\"'<>]//g")" | jq -r '.[0][0][]' | head -n1; }

# Converting audio and video files
function 2ogg() {
  eyeD3 --remove-all-images "$1"
  fname="${1%.*}"
  sox "$1" "$fname.ogg" && rm "$1"
}
function 2wav() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" "$fname.wav" && rm "$1"
}
function 2aif() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" "$fname.aif" && rm "$1"
}
function 2mp3() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" "$fname.mp3" && rm "$1"
}
function 2mov() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" "$fname.mov" && rm "$1"
}
function 2mp4() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" "$fname.mp4" && rm "$1"
}
function 2avi() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" "$fname.avi" && rm "$1"
}
function 2webm() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" -c:v libvpx "$fname.webm" && rm "$1"
}
function 2h265() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" -c:v libx265 "$fname'_converted'.mp4" && rm "$1"
}
function 2flv() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" "$fname.flv" && rm "$1"
}
function 2mpg() {
  fname="${1%.*}"
  ffmpeg -threads 0 -i "$1" "$fname.mpg" && rm "$1"
}

function 2jpeg() {
  fname="${1%.*}"
  convert "$1" "$fname.jpg" && rm "$1"
}
function 2jpg() {
  fname="${1%.*}"
  convert "$1" "$fname.jpg" && rm "$1"
}
function 2png() {
  fname="${1%.*}"
  convert "$1" "$fname.png" && rm "$1"
}
function 2bmp() {
  fname="${1%.*}"
  convert "$1" "$fname.bmp" && rm "$1"
}
function 2tiff() {
  fname="${1%.*}"
  convert "$1" "$fname.tiff" && rm "$1"
}
function 2gif() {
  fname="${1%.*}"
  if [ ! -d "/tmp/gif" ]; then mkdir "/tmp/gif"; fi
  if [ ${1: -4} == ".mp4" ] || [ ${1: -4} == ".mov" ] || [ ${1: -4} == ".avi" ] || [ ${1: -4} == ".flv" ] || [ ${1: -4} == ".mpg" ] || [ ${1: -4} == ".webm" ]; then
    ffmpeg -i "$1" -r 10 -vf 'scale=trunc(oh*a/2)*2:480' /tmp/gif/out%04d.png
    convert -delay 1x10 "/tmp/gif/*.png" -fuzz 2% +dither -coalesce -layers OptimizeTransparency +map "$fname.gif"
  else
    convert "$1" "$fname.gif"
    rm "$1"
  fi
  rm -r "/tmp/gif"
}

function weather() { curl -s http://wttr.in/$1; }
