" Toggle comment
let s:comment_map = { 
	\ "c": '\/\/',
	\ "java": '\/\/',
	\ "lua": '--',
	\ "python": '#',
	\ "sh": '#',
	\ "conf": '#',
	\ "zshrc": '#',
	\ "zsh": '#',
	\ "vim": '"',
	\ "tex": '%',
	\ "make": '#',
	\ "tmux": '#',
	\}

function! ToggleComment()
	if has_key(s:comment_map, &filetype)
		let comment_leader = s:comment_map[&filetype]
		if getline('.') =~ "^\\s*" . comment_leader . " " 
			" Uncomment the line
			execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
		else 
			if getline('.') =~ "^\\s*" . comment_leader
				" Uncomment the line
				execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
			else
				" Comment the line
				execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
			end
		end
	else
		echo "No comment leader found for filetype"
	end
endfunction

