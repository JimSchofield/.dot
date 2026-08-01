#!/usr/bin/env bash
#
# Symlinks dotfiles from this repo into $HOME.
# Safe to re-run: existing correct links are left alone, and anything
# real that would be clobbered gets backed up first.
#
#   ./install.sh          # link everything
#   ./install.sh --dry-run # show what would happen

set -euo pipefail

DOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
DRY_RUN=false

[ "${1:-}" = "--dry-run" ] && DRY_RUN=true

# repo path -> target in $HOME
links=(
    ".profile.link:.zprofile"
    ".tmux.conf.link:.tmux.conf"
    ".tigrc.link:.tigrc"
)

link_one() {
    local src="$DOT/$1" dest="$HOME/$2"

    if [ ! -e "$src" ]; then
        echo "skip   $2 (missing in repo: $1)"
        return
    fi

    # Already pointing where we want.
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        echo "ok     $2"
        return
    fi

    if $DRY_RUN; then
        echo "would  $2 -> $1"
        return
    fi

    # Back up anything real (or a link somewhere else) before replacing.
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/$2"
        echo "backup $2 -> $BACKUP_DIR/$2"
    fi

    ln -s "$src" "$dest"
    echo "link   $2 -> $1"
}

for pair in "${links[@]}"; do
    link_one "${pair%%:*}" "${pair##*:}"
done

# .gitconfig is deliberately not symlinked: the committed copy uses a
# public email, while machines often need a work address. Include the
# repo version instead so local overrides stay local.
if ! git config --global --get-all include.path 2>/dev/null | grep -qx "$DOT/.gitconfig"; then
    if $DRY_RUN; then
        echo "would  git include.path -> $DOT/.gitconfig"
    else
        git config --global --add include.path "$DOT/.gitconfig"
        echo "link   git include.path -> $DOT/.gitconfig"
    fi
else
    echo "ok     git include.path"
fi

echo
echo "Done. Check tooling with: $DOT/check_for_tools.sh"
