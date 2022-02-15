# PROMPT='%B%F{68}%.%f%b %F{178}>%f '

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr '%{%F{red}%B%} ●%{%b%f%}'
zstyle ':vcs_info:*' stagedstr '%{%F{green}%B%} ●%{%b%f%}'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '%b%u%c'
zstyle ':vcs_info:git:*' actionformats '%b|%u%c - %a'

PROMPT='
%F{213}${vcs_info_msg_0_}%f
%B%F{68}%.%f%b %F{178}>%f '

# turn on auto completion
autoload -Uz compinit && compinit
# case insensitive path-completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}';

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
