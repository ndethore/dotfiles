# heavily inspired by the wonderful pure theme
# https://github.com/sindresorhus/pure

autoload colors && colors

git_is_repo() {
 command git rev-parse --is-inside-work-tree &>/dev/null
}

git_branch_name() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
	echo -n "${ref#refs/heads/}"
}

git_has_changes() {
	local STATUS=''
	STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
	
 	if [[ -n $STATUS ]]; then return 0
	else return 1
	fi
}

prompt_git() {
   if ! git_is_repo ; then
	    return
    fi

    echo -n " on "

    branch=$(git_branch_name)
    echo -n "%F{241}$branch%f"

    echo -n "%F{208}"
    if git_has_changes ; then
        echo -n "*"
    else
	commit_count=$(command git rev-list --count --left-right "@{upstream}...HEAD" 2>/dev/null)
	case $commit_count in
		"") echo -n "";; # no upstream
		0$'\t'0) echo -n "";; # nothing to push or pull
		*$'\t'0) echo -n "↓";;
		0$'\t'*) echo -n "↑";;
		*) echo -n "⥄";;
	esac
     fi
    echo -n "%f"
}

upstream_branch() {
    remote=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD)) 2>/dev/null
    if [[ $remote != "" ]]; then
        echo "%F{241}($remote)%f"
    fi
}




precmd() {
}

prompt_end() {
	echo -n "%{%f%}"
}

prompt_dir() {
	echo -n '%F{6}%~%f'
}

prompt_status() {
	[[ $RETVAL -ne 0 ]] && echo -n "✘"
  	[[ $UID -eq 0 ]] && echo -n "⚡"
  	[[ $(jobs -l | wc -l) -gt 0 ]] && echo -n "⚙"
}

prompt_symbol() {
	local colors
	colors=(240 245 250)
	echo -n " "
	for color in $colors; do 
		echo -n "%F{$color}>%f"
	done
}

build_prompt() {
	RETVAL=$?
	prompt_status
	prompt_dir
	prompt_git
	# prompt_symbol
	prompt_end
}

PROMPT_SYMBOL='»'

export PROMPT='$(build_prompt) $PROMPT_SYMBOL '
export RPROMPT='%F{240}`date "+%H:%M:%S"`%f'
