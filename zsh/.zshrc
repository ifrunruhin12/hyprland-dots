# Suppress Powerlevel10k instant prompt warning
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Set theme to Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting history-substring-search)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Enable syntax highlighting
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Load SSH agent socket path from gnome-keyring-daemon
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/keyring/ssh"

# Set default editor
export EDITOR="nvim"

# History settings
HISTSIZE=2000
SAVEHIST=2000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY

# Enable case-insensitive completion
CASE_SENSITIVE="false"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Enable useful options
setopt autocd
setopt correct
setopt no_beep

# Custom aliases
alias ll="ls -la"
alias gs="git status"
alias gl="git log"
alias gf="git fetch"
alias mkcd="mkdir -p $1 && cd $1"

# Improve prompt
autoload -Uz promptinit
promptinit

# Load Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up colors for ls
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Set path for custom binaries
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

#ibus-setup
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus



# Load waifu image on terminal startup (choose one)
#chafa ~/Pictures/waifu.png  # Colored ASCII art (chafa)
# jp2a --width=50 ~/Pictures/waifu.png  # Black & white ASCII art (jp2a)

# Show a random waifu image
# chafa $(find ~/Pictures/waifus -type f | shuf -n 1)
#chafa -c none --symbols ascii $(find ~/Pictures/waifus -type f | shuf -n 1)
# Move waifu ASCII art to a separate script for faster startup
# If you still want to load the waifu automatically, uncomment this:
(~/.waifu.sh &)
