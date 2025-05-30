HISTSIZE=1000

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Git aliases
alias g='git status'
alias gitundocommit='git reset HEAD~'

# Import local aliases (contains aliases I don't want on every device like directory bookmarks)
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# Change default editor
EDITOR=nano

# Set command prompt
prompt off

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'

zstyle ':vcs_info:git:*' formats "[%b%u%c]"

zstyle ':vcs_info:git*+set-message:*' hooks untracked-git
+vi-untracked-git(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='%%'
    fi
}

setopt prompt_subst
PS1='%F{4}%n@%m%F{2}[%*]${vcs_info_msg_0_}%f:%F{6}%1~%f$ '


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

source /usr/local/rvm/scripts/rvm
