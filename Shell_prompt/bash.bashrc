# Command history tweaks:
# - Append history instead of overwriting
#   when shell exits.
# - When using history substitution, do not
#   exec command immediately.
# - Do not save to history commands starting
#   with space.
# - Do not save duplicated commands.
shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

# ======= Git Prompt Setup =======
# Load git-prompt.sh
if [ -f /usr/share/git/git-prompt.sh ]; then
        source /usr/share/git/git-prompt.sh
elif [ -f ~/.git-prompt.sh ]; then
        source ~/.git-prompt.sh
fi

# Show dirty state (modified/untracked files)
export GIT_PS1_SHOWDIRTYSTATE=1  # Enables * and +
# Show upstream tracking info (ahead/behind)
export GIT_PS1_SHOWUPSTREAM=auto
# Show stash state (+ if stashes exist)
export GIT_PS1_SHOWSTASHSTATE=1 # Enables %
export GIT_PS1_SHOWUNTRACKEDFILES=1 # Enables ?

# Git Prompt Function (Dynamic)
parse_git_branch() {
        local branch="$(__git_ps1 "%s")"
        if [ -n "$branch" ]; then
                echo -e "\e[1;34mgit:(\e[1;31m$branch\e[1;34m)\e[1;32m➜\e[0m"
        else
                echo ""
        fi
}

# ================================

# Default command line prompt.
PROMPT_DIRTRIM=2
# Test if PS1 is set to the upstream default value, and if so overwrite it with our default.
# This allows users to override $PS1 by passing it to the invocation of bash as an environment variable




# Prompt symbols
PROMPT_SYMBOL_USER="✘"      # "➤"
PROMPT_SYMBOL_ROOT="☠"

# Detect user and build prompt
if [ "$UID" -eq 0 ]; then
    # Root (Red style)
        [[ "$PS1" == '\s-\v\$ ' ]] && PS1='\[\e[1;31m\][ROOT]\[\e[1;32m\]➜ \[\e[1;36m\]\w\[\e[0m\]\[\e[1;32m\]➜ $(parse_git_branch) \[\e[1;31m\]$PROMPT_SYMBOL_ROOT \[\e[0m\]'
else
    # Normal user (Neon style)
        [[ "$PS1" == '\s-\v\$ ' ]] && PS1='\[\e[1;90m\][CyX]\[\e[1;32m\]➜ \[\e[1;36m\][\w]\[\e[0m\]\[\e[1;32m\]➜ $(parse_git_branch) \[\e[1;33m\]$PROMPT_SYMBOL_USER\[\e[0m\] '
fi



# [[ "$PS1" == '\s-\v\$ ' ]] && PS1='\[\e[1;32m\]➜  \[\e[1;36m\]\w\[\e[0m\] $(parse_git_branch) '

# Handles nonexistent commands.
# If user has entered command which invokes non-available
# utility, command-not-found will give a package suggestions.
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
        command_not_found_handle() {
                /data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
        }
fi

[ -r /data/data/com.termux/files/usr/share/bash-completion/bash_completion ] && . /data/data/com.termux/files/usr/share/bash-completion/bash_completion
