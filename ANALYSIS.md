# Repository Analysis

## Summary

This repository is a personal dotfiles workspace centered on editor and terminal tooling rather than a full Stow-style dotfiles package layout.

The actively tracked configuration currently includes:

- Neovim at [`config/nvim`](/Users/abhinav.kant/Development/dotfiles/config/nvim)
- tmux at [`config/tmux/tmux.conf`](/Users/abhinav.kant/Development/dotfiles/config/tmux/tmux.conf)
- Alacritty at [`config/alacritty/alacritty.toml`](/Users/abhinav.kant/Development/dotfiles/config/alacritty/alacritty.toml)

## Current Structure

- [`README.md`](/Users/abhinav.kant/Development/dotfiles/README.md) documents generic symlink and GNU Stow workflows.
- [`AGENT.md`](/Users/abhinav.kant/Development/dotfiles/AGENT.md) is intended to guide future repo edits.
- [`config/nvim/init.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/init.lua) boots the Neovim config through `config.lazy`.
- [`config/nvim/lua/config`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/config) contains core Neovim setup such as options, keymaps, and `lazy.nvim` bootstrap.
- [`config/nvim/lua/plugins`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/plugins) contains per-plugin configuration files.

## Neovim State

- Plugin management is handled with `lazy.nvim`.
- LSP setup is concentrated in [`config/nvim/lua/plugins/lsp.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/plugins/lsp.lua).
- Treesitter setup is concentrated in [`config/nvim/lua/plugins/treesitter.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/plugins/treesitter.lua).
- SQL support currently has two parts:
  - `sqlls` is included in the Mason/LSP setup.
  - the `sql` Treesitter parser is included for syntax highlighting.

## Observations

- The README is broader and more generic than the actual repository contents.
- The repo layout is `config/...` based, not a complete Stow-ready package structure.
- The Neovim plugin directory includes a few signs of ongoing iteration, such as backup or misspelled filenames like [`config/nvim/lua/plugins/cmp.lua.bak`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/plugins/cmp.lua.bak) and [`config/nvim/lua/plugins/makrdown-preview.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/plugins/makrdown-preview.lua).
- The SQL highlighting issue was a configuration-location problem: highlighting belongs to Treesitter, while LSP only adds language-server features.

## Risks And Gaps

- The README may mislead future edits if treated as the source of truth for the current filesystem layout.
- The Neovim config mixes newer plugin files with leftover artifacts, which increases the chance of duplicate or conflicting configuration.
- Runtime verification still matters for editor features such as Treesitter highlighting, Mason installs, and language-server startup.

## Suggested Next Steps

- Keep Neovim plugin responsibilities separated by file and avoid duplicate plugin specs across multiple files.
- Update the README so it distinguishes clearly between generic dotfiles guidance and this repo's actual structure.
- Remove or intentionally document backup/typo-named plugin files once their purpose is confirmed.
- Validate Neovim changes in-editor when changing Treesitter, Mason, or LSP behavior.
