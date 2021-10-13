# Prompt -----------------------------------------------------------------------
PROMPT='%F{#626b85}%n@%m%f %F{#8FAAC9}%~%f %F{#AEC694}>%f '
#-------------------------------------------------------------------------------

# Aliases ----------------------------------------------------------------------
## Shortcuts
alias z="source ~/.zshrc"
alias c="clear"
alias md="mkdir -p"
alias ct="clear; exa --tree"

## Tools
alias n="nvim"
alias t="todo.sh -d ~/.todo/config -f -n -A -P"
alias cls="clear; todo.sh -d ~/.todo/config -f -n -A -P ls"
alias ta="tmux attach -t"
alias tn="tmux new-session -s"
alias tree="exa --tree"
alias we="clear; curl wttr.in/Garching"
alias wea="clear; curl v2d.wttr.in/Garching"

## Other
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
#-------------------------------------------------------------------------------

# Functions --------------------------------------------------------------------
## fzf
function nf() { fzf | xargs nvim ;}
function cf() { cd $(find . -type d | fzf) ;}

## Git
function gitrm() { git ls-files | fzf -m | xargs git rm ;}
function gitadd() { fzf -m | xargs git add ;}
function gitquick() {
	git add -A
	git commit -m "$1"
	git push
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

# Vim --------------------------------------------------------------------------
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

# Oh-my-zsh --------------------------------------------------------------------
export ZSH=$HOME/.oh-my-zsh
plugins=(
	git
)
source $ZSH/oh-my-zsh.sh
#-------------------------------------------------------------------------------

# Tools ------------------------------------------------------------------------
## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
# export FZF_DEFAULT_OPTS=''
#-------------------------------------------------------------------------------
