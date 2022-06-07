# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="minimal"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias "cd ..."="cd ../.."
alias "cd ...."="cd ../../.."
alias "extend-right"="xrandr --output HDMI-1 --auto --right-of eDP-1"
alias "extend-left"="xrandr --output HDMI-1 --auto --left-of eDP-1"
alias "extend-top"="xrandr --output HDMI-1 --auto --above eDP-1"
alias "py"="python"
alias "b"="bluetoothctl"
alias "vim"="nvim"
alias "sd"="poweroff"
alias "sp"="systemctl suspend"
alias "re"="reboot"
alias "ga"="git add"
alias "gaa"="git add --all"
alias "gap"="git add --patch"
alias "gs"="git status"
alias "gc"="git commit"
alias "gpl"="git pull"
alias "gps"="git push"
alias "mca"="make clean all"
alias "ga"="git add ."
alias "gcm"="git commit -m "
alias "gdc"="git diff --cached "
alias "juggle"="~/.local/bin/JugglingLab.sh"
alias "se"="sudoedit"
alias "pipe"="cpipes -c cc241d -c d79921 -c 458588 -c b16286 -c 689d6a -p 2 -m 120 -r 0.1"
alias "l"="lsd"
alias "la"="lsd -a"
alias "ll"="lsd -l"
alias "lla"="ls -la"
alias "cgo"="cargo"
alias "cgr"="cargo run"
alias "cgb"="cargo build"
alias "cgc"="cargo build"
alias "ssh"="TERM=xterm-256color \ssh"
alias "ch"="bluetoothctl power on;bluetoothctl connect 70:BF:92:20:BB:BF"
alias "dh"="bluetoothctl disconnect 70:BF:92:20:BB:BF"
alias "caps"="setxkbmap -option caps:swapescape"
alias "no-caps"="setxkbmap -option caps:swapescape"
alias "c"="clear"

# nvim terminal specific settings
# taken from neev
export EDITOR='nvim'
export VISUAL='nvim'
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
  alias e='nvr'
  export VISUAL='nvr -cc split --remote-wait -c "set bufhidden=delete"'
  export EDITOR="$VISUAL"
fi

source /usr/share/nvm/init-nvm.sh

export FZF_DEFAULT_COMMAND='rg --files'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/dotfiles/scripts:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.cargo/bin:/usr/local/go/bin:$HOME/go/bin:$HOME/.local/bin:$HOME/ardupilot/Tools/autotest:/usr/lib/ccache:$HOME/gcc-arm/gcc-arm-none-eabi-6-2017-q2-update/bin:$PATH"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/thomas/wlkata/Wlkatastudio"
