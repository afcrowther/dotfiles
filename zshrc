export ZSH=~/.oh-my-zsh

ZSH_THEME="pygmalion-virtualenv"

DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
plugins=(docker git github tmux kubectl virtualenv)
source $ZSH/oh-my-zsh.sh

# Setup docker host for WSL
# WSL (Windows Subsystem for Linux) specific settings.
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
    # Adjustments for WSL's file / folder permission metadata.
    if [ "$(umask)" = "0000" ]; then
      umask 0022
    fi

    # Configure the Docker CLI to use the Docker for Windows daemon.
    #   Requires: https://docs.docker.com/docker-for-windows/install/
    export DOCKER_HOST=tcp://localhost:2375
fi

# Source custom aliases
source ~/.aliases

# Source custom functions
source ~/.functions.sh

# Use lvim as default
export EDITOR=lvim

# colors!
export TERM=xterm-256color

# java home
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Enable virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=

# Source secrets if available
[ -f ~/.secrets.sh ] && source ~/.secrets.sh

# Setup fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -d "$HOME/.local/bin" ]; then
    PATH=$HOME/.local/bin:$PATH
fi

