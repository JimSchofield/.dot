# My dot files

A simple setup to help me when switching computers.

## Install

```sh
git clone <this repo> ~/.dot
cd ~/.dot
./install.sh --dry-run   # see what it would do
./install.sh             # create the symlinks
./check_for_tools.sh     # verify required tools are present
```

`install.sh` is idempotent. Anything it would overwrite is moved to
`~/.dotfiles-backup/<timestamp>/` first.

## What links where

| Repo file          | Target        |
| ------------------ | ------------- |
| `.profile.link`    | `~/.zprofile` |
| `.tmux.conf.link`  | `~/.tmux.conf`|
| `.tigrc.link`      | `~/.tigrc`    |

`.gitconfig` is **not** symlinked. `install.sh` adds it via `include.path`
in the global git config, so machine-specific settings (like a work email)
can live in `~/.gitconfig` without conflicting with the committed copy.

## Layout

- `.profile.link` — PATH, aliases, fzf init. Sourced as `~/.zprofile`.
- `.profile.linux` — Linux-only extras, sourced automatically on Linux.
- `~/.zprofile_work` — optional, untracked; sourced last so work settings win.
- `.tmux.conf.link` — tmux config, incl. vim-tmux-navigator bindings.
- `.tmux.util` — helper functions called from tmux bindings.
- `bin/tm` — fzf tmux session switcher. Needs `~/bin` on PATH.
- `fzf/` — vendored fzf completion and key bindings.
- `tokyo-night/` — tmux + iTerm colour schemes.

## Notes

- The prompt comes from [starship](https://starship.rs), configured outside
  this repo in `~/.zshrc`. The `.zshrc` here is an older vcs_info prompt kept
  for reference; it is not linked.
- `TERM` is only forced to `screen-256color` inside tmux, so truecolor works
  in the terminal proper.
