# Prompt
PROMPT='%F{#626b85}%n@%m%f %F{#8FAAC9}%~%f %F{#AEC694}>%f '

# Aliases
alias n="nvim"
alias c="clear"
alias t="tmux"
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
plugins=(
	git
)
source $ZSH/oh-my-zsh.sh

# General
