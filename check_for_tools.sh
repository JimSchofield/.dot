#!/usr/bin/env bash
#
# Checks that the tools this setup assumes are actually installed.
# Run manually after setting up a new machine: ./check_for_tools.sh

echo 'Checking for necessary tools...'

# Things the shell config / aliases / nvim will break without.
required_apps=(
    brew
    fd
    fzf
    git
    lsd     # `li` and `tree` aliases
    node
    npm
    nvim
    rg      # telescope live_grep
    tig     # tmux <leader>g popup
    tmux
)

# Nice to have, but nothing here breaks without them.
optional_apps=(
    bat
    dust
    go
)

something_missing=false

command_missing() {
    ! type "$1" &> /dev/null
}

for app in "${required_apps[@]}"; do
    if command_missing "$app"; then
        echo "MISSING (required): $app"
        something_missing=true
    fi
done

for app in "${optional_apps[@]}"; do
    if command_missing "$app"; then
        echo "missing (optional): $app"
    fi
done

if [ "$something_missing" = "true" ]; then
    echo "Missing some required programs."
    exit 1
fi

echo "You're all set! 😃"
