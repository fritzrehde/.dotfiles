# Aliases ----------------------------------------------------------------------
alias z="source ~/.zshrc"
alias c="clear"
alias ct="clear; exa --tree"
alias ..="cd .."
alias update="sudo pacman -Syu"
alias yy="fc -ln -1 | tr -d '\n' | xclip -selection clipboard -i"
alias open="xdg-open"

## Shell scripts
alias n='~/.scripts/nvim/nvim.sh'
alias t='~/.scripts/tmux/tmux.sh'
alias gq='~/.scripts/git/gitquick.sh'
alias tab='~/.scripts/util/tab.sh'
alias dot='~/.scripts/git/dotfiles.sh'
#-------------------------------------------------------------------------------

# Functions --------------------------------------------------------------------
function gc() { git clone -q "$1"; cd $(basename "$1" | sed -e 's/.git//g'); clear; exa --tree ;}
#-------------------------------------------------------------------------------

# Variables --------------------------------------------------------------------
export EDITOR=nvim

## Clipmenu
export CM_LAUNCHER=rofi
export CM_OUPUT_CLIP=0
export CM_MAX_CLIPS=10
#-------------------------------------------------------------------------------

# Prompt -----------------------------------------------------------------------
PROMPT='%F{#616E88}%n@%m%f %F{#8FAAC9}%~%f%F{#AEC694}$(git_branch)%f %F{#AEC694}>%f '
setopt PROMPT_SUBST
function git_branch() { git symbolic-ref --short HEAD 2> /dev/null | sed -n -e 's/.*/ (&)/p' ;}
#-------------------------------------------------------------------------------

# Vim-Mode ---------------------------------------------------------------------
set -o vi
bindkey -v # Activate vi-mode
KEYTIMEOUT=1 # Remove mode switching delay

# Change cursor shape for different vi modes
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
			echo -ne '\e[1 q'

	elif [[ ${KEYMAP} == main ]] || 
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} = '' ]] ||
		[[ $1 = 'beam' ]]; then
			echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt
preexec() {
	echo -ne '\e[5 q'
}
#-------------------------------------------------------------------------------

# Completion -------------------------------------------------------------------
autoload -U compinit
compinit
zstyle ':completion:*' menu select # colour current tab completion item
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case sensitivity
#-------------------------------------------------------------------------------

# opam configuration
[[ ! -r /home/fritz/.opam/opam-init/init.zsh ]] || source /home/fritz/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Tools ------------------------------------------------------------------------
## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_BINDINGS="--bind='tab:toggle+down' \
	--bind='P:toggle-preview' \
	--bind='J:down' \
	--bind='K:up' \
	--bind='btab:toggle+clear-query+first' \
	--bind='A:toggle-all'"
export FZF_DEFAULT_OPTS="$FZF_BINDINGS \
	--multi \
	--reverse \
	--no-info \
	--preview-window=65%,hidden,border-sharp \
	--color=border:#444B5D \
		--color=prompt:#AEC694 \
		--color=pointer:#8FAAC9 \
		--color=gutter:#2e3440 \
		--color=bg+:#444B5D \
		--color=marker:red \
		--color=header:#8FAAC9 \
		--color=query:regular"
#-------------------------------------------------------------------------------
