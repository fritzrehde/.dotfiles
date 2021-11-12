# Prompt -----------------------------------------------------------------------
PROMPT='%F{#626b85}%n@%m%f %F{#8FAAC9}%~%f%F{#AEC694}$(git_branch)%f %F{#AEC694}>%f '
setopt PROMPT_SUBST
function git_branch() {
	git symbolic-ref --short HEAD 2> /dev/null | sed -n -e 's/.*/ (&)/p'
}
#-------------------------------------------------------------------------------

# Aliases ----------------------------------------------------------------------
## Shortcuts
alias z="source ~/.zshrc"
alias c="clear"
alias md="mkdir -p"
alias ct="clear; exa --tree"
alias ..="cd .."

## Tools
alias n="nvim"
alias g="git"
alias gc="gc"
alias t="todo.sh -d ~/.todo/config -f -n -A -P"
alias cls="clear; todo.sh -d ~/.todo/config -f -n -A -P ls"
alias ta="tmux attach -t"
alias tree="exa --tree"
alias we="clear; curl wttr.in/Garching"
alias wea="clear; curl v2d.wttr.in/Garching"

## Other
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot2='/usr/bin/git --git-dir=$HOME/.dotfiles2/ --work-tree=$HOME'
#-------------------------------------------------------------------------------

# Functions --------------------------------------------------------------------
## fzf
function nf() { fzf --height 20% --layout=reverse | xargs nvim ;}
function cf() { cd $(find . -type d | fzf) ;}

## Git
function gitrm() { git ls-files | fzf -m | xargs git rm ;}
function gitadd() { fzf -m | xargs git add ;}
function gq() {
	git add -A
	git commit -m "$*"
	git push
}

## Tmux
function nt() { 
	for a in "$@"
	do
		tmux new-window "nvim $a" 
	done
}
function m() { tmux new-window "man $@" ;}
function tn() {
	if [[ $# == 1 ]]; then
		tmux new-session -A -s "$1"
	else
		tmux new-session -A -s misc
	fi
}

## General
function cpwd() { pwd | pbcopy } # copy current working directory to clipboard
function cdx() { cd "$@" && exa ;}
function tab() { # convert files from spaces to tabs
	tab_size=$1
	shift
	for a in "$@"
	do
		unexpand -t "$tab_size" $a > $a-notab
		mv $a-notab $a
	done
}

# TODO: compress pdf 
# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed_PDF_file.pdf input_PDF_file.pdf
# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed_PDF_file.pdf input_PDF_file.pdf
# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed_PDF_file.pdf input_PDF_file.pdf
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

# Tools ------------------------------------------------------------------------
## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
# export FZF_DEFAULT_OPTS=''
#-------------------------------------------------------------------------------

# Completion -------------------------------------------------------------------
autoload -U compinit
compinit
zstyle ':completion:*' menu select # colour current tab completion item
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case sensitivity
#-------------------------------------------------------------------------------

# opam configuration
[[ ! -r /Users/Fritz/.opam/opam-init/init.zsh ]] || source /Users/Fritz/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# export LESS_TERMCAP_mb=$'\e1;32m'
# export LESS_TERMCAP_md=$'\e[1;32m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;33m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;4;31m'
