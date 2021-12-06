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
alias ..="cd .."

## Tools
alias ct="clear; exa --tree"
alias g="git"
# alias todo="todo.sh -d ~/.todo/config -fnAP"
alias tree="exa --tree"
alias we="clear; curl v2d.wttr.in/Garching"

## Other
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot2='/usr/bin/git --git-dir=$HOME/.dotfiles2/ --work-tree=$HOME'
#-------------------------------------------------------------------------------

# Functions --------------------------------------------------------------------
## Tmux popups
function tmux_nvim()
{
	FZF_OPTS=(--preview='cat {}')
	current_path=$(tmux display-message -p '#{pane_current_path}')
	if search_path=$(cd "$current_path"; git rev-parse --show-toplevel 2> /dev/null) ; then
		FZF_OPTS+=(--header=$(basename ${search_path}))
	else
		search_path=~/code
	fi

	count=$(tmux display-message -p '#{session_windows}')
	(cd $search_path; fd -t f --base-directory $search_path | cut -c 3- | fzf ${FZF_OPTS} | tac | xargs -I % tmux new-window -a -d "nvim %")
	new_count=$(tmux display-message -p '#{session_windows}')
	if [[ count -ne new_count ]]; then tmux next-window; fi # go to next window only if a file was opened
}
export TODO=~/.todo/config
function tmux_todo_do() { todo.sh -Pd $TODO ls | fzf -e --ansi --with-nth=2.. | grep -o '^[0-9][0-9]*' | xargs -J % todo.sh -fNAd $TODO do % }
function tmux_switch_session()
{
	current_session=$(tmux display-message -p '#{session_name}')
	tmux list-sessions -F '#{session_name}' | sed "/$current_session/d" | fzf +m -0 | xargs -I % tmux switch-client -t %
}
function tmux_kill_sessions()
{
	tmux switch-client -t misc
	tmux list-sessions -F '#{session_name}' | sed "/misc/d" | fzf -0 | xargs -I % tmux kill-session -t %
}

## fzf
function n()
{
	num_args=$#
	if [[ "$num_args" == 0 ]]; then # fzf
		count=$(tmux display-message -p '#{session_windows}')
		fd -t f | fzf --preview='cat {}' --margin 15,0,15,2% | tac | xargs -I % tmux new-window -a -d "nvim %"
		new_count=$(tmux display-message -p '#{session_windows}')
		if [[ count -ne new_count ]]; then tmux next-window; fi # go to next window only if a file was opened
	elif [[ "$num_args" == 1 ]]; then # default
		nvim "$1"
	else # arguments
		for a in "$@"
		do
			tmux new-window -a -d "nvim $a" 
		done
		tmux next-window
	fi
}
function cf() { cd $(find -f . -E '/.git/ d' -type d | fzf) ;}

## Git
function gq() { git add -A; git commit -m "$*"; git push ;}
function gc() { git clone -q "$1"; cd $(basename "$1" | sed -e 's/.git//g'); clear; exa --tree ;}

## Tmux
function t() # create new tmux session, if no argument attach misc 
{
	if [[ $# == 1 ]]; then
		tmux new-session -A -s "$1"
	else
		tmux new-session -A -s misc
	fi
}

## General
function tab() # convert spaces to tabs
{
	tab_size=$1
	shift
	for a in "$@"
	do
		unexpand -t "$tab_size" $a > $a-notab
		mv $a-notab $a
	done
}
function cpwd() { pwd | pbcopy } # copy current working directory to clipboard
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
[[ ! -r /Users/Fritz/.opam/opam-init/init.zsh ]] || source /Users/Fritz/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Tools ------------------------------------------------------------------------
## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_BINDINGS="--bind='tab:toggle+down' \
	--bind='btab:down' \
	--bind='P:toggle-preview' \
	--bind='Q:clear-query+first' \
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
