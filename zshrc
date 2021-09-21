export ZSH=~/.oh-my-zsh

ZSH_THEME="pygmalion-virtualenv"

DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
plugins=(docker git github tmux kubectl virtualenv)
source $ZSH/oh-my-zsh.sh

# Setup fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup docker host for WSL
# WSL (Windows Subsystem for Linux) specific settings.
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
    # Adjustments for WSL's file / folder permission metadata.
    if [ "$(umask)" = "0000" ]; then
      umask 0022
    fi

    # Access local X-server with VcXsrv.
    #   Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
    export DISPLAY=:0

    # Configure the Docker CLI to use the Docker for Windows daemon.
    #   Requires: https://docs.docker.com/docker-for-windows/install/
    export DOCKER_HOST=tcp://localhost:2375
fi

# Source custom aliases
source ~/.aliases

# Source custom functions
source ~/.functions.sh

# Use neovim as default
export EDITOR=nvim

# colors!
export TERM=xterm-256color

# java home
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Ruby gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# Enable virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=
