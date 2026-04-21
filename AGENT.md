# AGENT.md

## Project Overview

This repository is a personal dotfiles/configuration workspace. At the time of writing, the active tracked configuration is centered on:

- `config/nvim/`: a Neovim setup written in Lua and managed with `lazy.nvim`
- `config/tmux/tmux.conf`: a tmux configuration with TPM plugins enabled
- `config/alacritty/alacritty.toml`: an Alacritty terminal configuration

The root [`README.md`](/Users/abhinav.kant/Development/dotfiles/README.md) describes general dotfiles and symlink workflows, but the checked-in repository is currently smaller and more concrete than that document suggests. Prefer the actual filesystem layout over README examples when making changes.

## Repository Layout

- `config/nvim/init.lua`
  Entrypoint that delegates to `config.lazy`.
- `config/nvim/lua/config/`
  Core Neovim behavior:
  - `lazy.lua`: bootstraps `lazy.nvim`, sets leaders, loads options and plugin specs
  - `options.lua`: editor defaults
  - `keymaps.lua`: user mappings
- `config/nvim/lua/plugins/`
  One plugin spec per file. This is the main extension surface for Neovim behavior.
- `config/nvim/lazy-lock.json`
  Plugin lockfile managed by `lazy.nvim`
- `config/tmux/tmux.conf`
  Tmux keybindings, status bar, and TPM plugin declarations
- `config/alacritty/alacritty.toml`
  Alacritty terminal configuration

## Tech Stack And Runtime Assumptions

- Neovim configuration language: Lua
- Plugin manager: `lazy.nvim`
- LSP/bootstrap helpers: `mason.nvim`, `mason-lspconfig.nvim`, `nvim-lspconfig`
- Completion: `blink-cmp` and `nvim-cmp`-related dependencies may both appear during migration
- Formatter orchestration: `conform.nvim`
- Treesitter: `nvim-treesitter` on the `main` branch
- Tmux plugin manager: TPM

This repo assumes external tools may exist on the machine, including:

- `git`
- `tmux`
- `nvim`
- formatters like `prettier`, `stylua`, `csharpier`, `sqlfluff`
- optional tooling referenced by plugins such as `bun`

The current Neovim LSP config in `config/nvim/lua/plugins/lsp.lua` also assumes these LSP-related tools are available through Mason or otherwise installed:

- `lua_ls` for Lua
- `ts_ls` for TypeScript and JavaScript
- `sqlls` for SQL
- one C# server, but the config is currently split:
  Mason ensures `csharp_ls`, while `nvim-lspconfig` enables `omnisharp`
- `hrsh7th/cmp-nvim-lsp` must remain installed because LSP capabilities are built via `require("cmp_nvim_lsp").default_capabilities()`

Do not silently remove references to external tools just because they are missing in one environment; call out missing prerequisites instead.
Do not assume C# LSP is healthy unless the Mason package name and the enabled `nvim-lspconfig` server name are aligned.

## How The Neovim Config Is Structured

Load order is:

1. `config/nvim/init.lua`
2. `config/nvim/lua/config/lazy.lua`
3. `config.options`
4. `lazy.nvim` plugin setup with `{ import = "plugins" }`
5. `config.keymaps`

Implications:

- New editor defaults belong in `config/nvim/lua/config/options.lua`
- New global mappings belong in `config/nvim/lua/config/keymaps.lua`
- Plugin additions or behavior changes usually belong in a dedicated file under `config/nvim/lua/plugins/`
- Prefer small plugin files over growing `plugins/init.lua`
- Syntax highlighting changes belong in Treesitter config, not LSP config
- Language-server installation and enablement belong in `config/nvim/lua/plugins/lsp.lua`
- When troubleshooting LSP, check both Mason `ensure_installed` entries and the later `vim.lsp.config(...)` / `vim.lsp.enable(...)` names; they currently differ for C#

## Conventions To Follow

- Preserve the current Lua style unless there is a strong reason to normalize formatting across the whole repo.
- Keep plugin configuration isolated per file under `config/nvim/lua/plugins/`.
- Treat `lazy-lock.json` as generated state:
  update it only when plugin changes require it, and avoid unrelated churn.
- Avoid renaming user files casually. Some filenames currently look imperfect but may already be wired into the user’s workflow or local untracked changes.
- Respect existing local work. This repository may be intentionally dirty while configs are being iterated on.
- Prefer updating the authoritative config file instead of introducing duplicate plugin specs in a second file.

## Validation Guidance

Prefer lightweight validation after changes:

- Neovim syntax sanity:
  `nvim --headless "+qa"`
- If plugin specs changed, open Neovim and verify `:Lazy` loads without errors
- If LSP/formatter config changed, verify the relevant filetype inside Neovim rather than assuming static analysis is enough
- For LSP-specific checks, confirm `:Mason` shows the expected packages and `:LspInfo` shows the expected attached server names for the current buffer
- If Treesitter changed, verify `:TSInstallInfo` or open the target filetype and confirm highlighting actually starts
- For tmux changes, reload with:
  `tmux source-file config/tmux/tmux.conf`

If a validation step cannot run because a dependency is unavailable, say so clearly in your summary.

## Known Project Realities

- The README describes manual symlink and GNU Stow approaches, but the current repository layout is not a complete Stow-style package layout.
- Neovim is the most actively evolving area of the repo.
- There are signs of in-progress plugin migration work in `config/nvim/lua/plugins/` and `config/nvim/lazy-lock.json`; avoid overwriting or “cleaning up” unrelated edits.
- Some plugin filenames appear to be backups or typos, such as `cmp.lua.bak` and `makrdown-preview.lua`; do not rename or delete them unless explicitly asked.
- `config/nvim/lua/plugins/lsp.lua` currently mixes `csharp_ls` in Mason with `omnisharp` in `vim.lsp.enable(...)`; treat that as an intentional issue to verify, not something to ignore.

## Good Change Patterns

- Add a new Neovim plugin:
  create a new file under `config/nvim/lua/plugins/` with a single plugin spec.
- Change a keybinding:
  edit `config/nvim/lua/config/keymaps.lua` unless the mapping is tightly coupled to a plugin and should lazy-load with that plugin.
- Change formatting behavior:
  edit `config/nvim/lua/plugins/conform.lua`.
- Change LSP installation or enablement:
  edit `config/nvim/lua/plugins/lsp.lua`.
- Change syntax highlighting / parser installation:
  edit `config/nvim/lua/plugins/treesitter.lua`.
- Change tmux UX:
  edit `config/tmux/tmux.conf`.
- Change terminal settings:
  edit `config/alacritty/alacritty.toml`.

## Things To Avoid

- Do not restructure the repo into a new dotfiles layout unless explicitly asked.
- Do not delete seemingly unused plugin files without checking whether the file is tracked, referenced, or part of in-progress local work.
- Do not assume the deployment target paths from the README are fully authoritative for the current repo.
- Do not overwrite `lazy-lock.json` as part of unrelated edits.
- Do not confuse SQL LSP support with SQL syntax highlighting; those are configured in different places.

## Preferred Agent Workflow

1. Inspect `git status --short` before editing.
2. Read the specific config files involved in the requested change.
3. Make the narrowest possible edit in the relevant config area.
4. Run a lightweight validation step when practical.
5. Summarize both code changes and anything you could not verify.

## File References

- [`README.md`](/Users/abhinav.kant/Development/dotfiles/README.md)
- [`config/nvim/init.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/init.lua)
- [`config/nvim/lua/config/lazy.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/config/lazy.lua)
- [`config/nvim/lua/config/options.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/config/options.lua)
- [`config/nvim/lua/config/keymaps.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/config/keymaps.lua)
- [`config/nvim/lua/plugins`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/plugins)
- [`config/nvim/lua/plugins/lsp.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/plugins/lsp.lua)
- [`config/nvim/lua/plugins/treesitter.lua`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lua/plugins/treesitter.lua)
- [`config/nvim/lazy-lock.json`](/Users/abhinav.kant/Development/dotfiles/config/nvim/lazy-lock.json)
- [`config/tmux/tmux.conf`](/Users/abhinav.kant/Development/dotfiles/config/tmux/tmux.conf)
- [`config/alacritty/alacritty.toml`](/Users/abhinav.kant/Development/dotfiles/config/alacritty/alacritty.toml)
