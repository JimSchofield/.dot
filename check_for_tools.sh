# Checking for required tools.
# In the future I think I'll do this in an install script, but for now it doesn't seem to
# slow down terminal load 

echo 'Checking for necessary tools...'

command_exists() {
    type "$1" > /dev/null 2>&1 || { echo >&2 "I require $1 but it doesn't exist! Make sure to intall it." }
}

required_apps=(
    bat
    fd
    fzf
    git
    http-server
    nvim
    rg
    tmux
    nvim
)

for app in "${required_apps[@]}"; do
    type "$app" > /dev/null 2>&1 || { echo >&2 "$app doesn't exist! Make sure to intall it." } 
done
