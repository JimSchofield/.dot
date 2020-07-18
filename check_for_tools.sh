# Checking for required tools.
# In the future I think I'll do this in an install script, but for now it doesn't seem to
# slow down terminal load 

echo 'Checking for necessary tools...'

required_apps=(
    bat
    brew
    exa
    fd
    fzf
    git
    node
    npm
    nvim
    rg
    rustc
    tig
    tmux
)

something_missing=false

command_missing() {
    if (type "$1" &> /dev/null); then
        return 1;
    else
        return 0;
    fi
}

for app in "${required_apps[@]}"; do
    if command_missing "$app"; then
        echo "$app is missing";
        something_missing=true
    fi
done

if [ "$something_missing" = "true" ]; then
    echo "Missing some programs."
else
    echo "You're all set! 😃"
fi
