
# Don't remember commands which start with space
setopt hist_ignore_space

# Set emacs mode
bindkey -e

# Make ^p and ^n search, like Up and Down
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Key codes depend on the terminal. Use `showkey -a` to check.
bindkey "${terminfo[khome]}" beginning-of-line   # Home
bindkey "^[[H"               beginning-of-line
bindkey "^[[1~"              beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line         # End
bindkey "^[[F"               end-of-line
bindkey "^[[4~"              end-of-line
bindkey "^[[3~"              delete-char         # Del
bindkey "^H"                 backward-kill-word  # Ctrl+Backspace (no tmux equivalent--use Alt instead)
bindkey "^[[1;3D"            backward-word       # Alt+Left
bindkey "^[[1;3C"            forward-word        # Alt+Right
bindkey "^[[1;5D"            backward-word       # Ctrl+Left
bindkey "^[[1;5C"            forward-word        # Ctrl+Right


alias nsh="nix-shell --command zsh -p"
ndev() {
    if [ "$#" -eq 0 ]; then
        nix develop '.?submodules=1#' --command zsh
    else
        nix develop "$@" --command zsh
    fi
}

type direnv > /dev/null && eval "$(direnv hook zsh)"
type zoxide > /dev/null && eval "$(zoxide init --cmd cd zsh)"

