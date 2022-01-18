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
alias tree="exa --tree"
alias we="clear; curl v2d.wttr.in/Garching"

## Other
alias dot2='/usr/bin/git --git-dir=$HOME/.dotfiles2/ --work-tree=$HOME'
#-------------------------------------------------------------------------------

# Functions --------------------------------------------------------------------
## Tmux popups
function popup_nvim()
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
function popup_nvim_config()
{
	count=$(tmux display-message -p '#{session_windows}')
	cat .config_files | fzf --preview='cat {}' | tac | xargs -I % tmux new-window -a -d "nvim %"
	new_count=$(tmux display-message -p '#{session_windows}')
	if [[ count -ne new_count ]]; then tmux next-window; fi # go to next window only if a file was opened
}
function popup_cd()
{
	current_window=$(tmux display-message -p '#{window_index}')
	search_path=$(tmux display-message -p '#{pane_current_path}')
	base_path=.
	if [[ $search_path -ef ~ ]]; then
		search_path=~/code
		base_path=$search_path
	fi
	new_path=$(fd -t d --base-directory $search_path | cut -c 3- | fzf +m)
	if [ ! -z $new_path ]; then
		tmux send-keys -t $current_window "cd $base_path/$new_path; clear" ENTER
	fi
}
export TODO=~/.todo/config
function popup_todo_do() { todo.sh -Pd $TODO ls | fzf -e --ansi --with-nth=2.. | awk '{print $1}' | tr '\n' ' ' | xargs -I % todo.sh -fnA do % }
function popup_todo_add() { echo -n "todo: "; read todo; todo.sh add ${todo} }
function popup_switch_session()
{
	current_session=$(tmux display-message -p '#{session_name}')
	tmux list-sessions -F '#{session_name}' | sed "/$current_session/d" | fzf +m -0 | xargs -I % tmux switch-client -t %
}
function popup_kill_sessions()
{
	tmux switch-client -t misc
	tmux list-sessions -F '#{session_name}' | sed "/misc/d" | fzf -0 | xargs -I % tmux kill-session -t %
}

## fzf
function n()
{
	num_args=$#
	if [[ "$num_args" == 1 ]]; then
		tmux new-window -a "nvim $1" 
	else # arguments
		for a in "$@"
		do
			tmux new-window -a -d "nvim $a" 
		done
		tmux next-window
	fi
}
function dot()
{
	dot_cmd=(/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME)
	if [[ $# == 0 ]]; then
		echo -n "Commit message: "
		read commit_msg
		cat .config_files | fzf --margin=14,0,15,1% | xargs -I % ${dot_cmd} add %
		${dot_cmd} commit -m "$commit_msg"; ${dot_cmd} push
	fi
	${dot_cmd} "$*"
}

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
