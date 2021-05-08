# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files source by it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
zstyle ':z4h:'                auto-update      'ask'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:'                auto-update-days '28'
# Automaticaly wrap TTY with a transparent tmux ('integrated'), or start a
# full-fledged tmux ('system'), or disable features that require tmux ('no').
zstyle ':z4h:'                start-tmux       'integrated'
# Move prompt to the bottom when zsh starts up so that it's always in the
# same position. Has no effect if start-tmux is 'no'.
zstyle ':z4h:'                prompt-at-bottom 'yes'
# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey'         keyboard 'mac'
# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'
# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# ssh when connecting to these hosts.
# example: zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'           enable 'no'
# Send these files over to the remote host when connecting over ssh to the
# enabled hosts.
zstyle ':z4h:ssh:*'           send-extra-files '~/.nanorc' '~/.env.zsh'

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# ---[ Environment ]-------------------------------------------
export LANG=en_US.UTF-8
export DOTFILES="$HOME/.dotfiles"
export GPG_TTY=$TTY
export GOPATH=$(go env GOPATH)
export FZF_DEFAULT_COMMAND="fd --type f"

# Default editor for local and remove environments
if [[ -n "$SSH_CONNECTION" ]]; then
  # on server
  if command -v vim >/dev/null 2>&1; then
    export EDITOR='vim'
  else
    export EDITOR='vi'
  fi
else
  export EDITOR='nvim'
fi

# Extend PATH.
path=(~/bin /usr/local/sbin $path)

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Define key bindings.
z4h bindkey undo           Ctrl+/       # undo the last command line change
z4h bindkey redo           Alt+/        # redo the last undone command line change
z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# ---[ Aliases ]-------------------------------------------
if command -v exa >/dev/null; then
  alias ls="exa"
  alias ll="exa -l --git"
  alias tree="exa --tree"
  alias gtree="exa -l --tree --git"
else
  alias tree='tree -a -I .git'
  alias ls="${aliases[ls]:-ls} -A"
fi

# Replace cat with bat
if command -v bat >/dev/null; then
  alias cat="bat"
fi

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
# Reference card: http://lanisolutions.com/wp-content/uploads/2011/05/oh-my-zsh_refcard.pdf
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu
