# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/stan/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="candy"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
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
eval $(thefuck --alias)

# Open the right editor when requested ;)
alias vim='vim'
alias vi='vim'
export EDITOR='vim'

alias grep-ip='grep -oE "\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b"'

alias cleanvar="cat /dev/null > /var/log/syslog & cat /dev/null > /var/log/messages & cat /dev/null > /var/log/user.log"

# Pwndoc docker shortcuts
alias pwndoc-backend-restart='docker-compose -f ~/repositories/pwndoc/backend/docker-compose.dev.yml restart'
alias pwndoc-backend-stop='docker-compose -f ~/repositories/pwndoc/backend/docker-compose.dev.yml stop'
alias pwndoc-backend-start='docker-compose -f ~/repositories/pwndoc/backend/docker-compose.dev.yml start'
alias pwndoc-backend-down='docker-compose -f ~/repositories/pwndoc/backend/docker-compose.dev.yml down'
alias pwndoc-backend-logs='docker-compose -f ~/repositories/pwndoc/backend/docker-compose.dev.yml logs -f pwndoc-backend'
alias pwndoc-frontend-restart='docker-compose -f ~/repositories/pwndoc/frontend/docker-compose.dev.yml restart'
alias pwndoc-frontend-stop='docker-compose -f ~/repositories/pwndoc/frontend/docker-compose.dev.yml stop'
alias pwndoc-frontend-start='docker-compose -f ~/repositories/pwndoc/frontend/docker-compose.dev.yml start'
alias pwndoc-frontend-down='docker-compose -f ~/repositories/pwndoc/frontend/docker-compose.dev.yml down'
alias pwndoc-frontend-logs='docker-compose -f ~/repositories/pwndoc/frontend/docker-compose.dev.yml logs -f pwndoc-frontend'
alias pwndoc-restart='pwndoc-backend-restart; pwndoc-frontend-restart'
alias pwndoc-stop='pwndoc-backend-stop; pwndoc-frontend-stop'
alias pwndoc-start='pwndoc-backend-start; pwndoc-frontend-start'
