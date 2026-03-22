vim.opt.expandtab = true -- Converts tabs to space
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>

vim.opt.tabstop = 4 -- How many spaces are shown per TAB
vim.opt.softtabstop = 4 -- How many spaces are applied when pressing TAB

vim.opt.smarttab = true 
vim.opt.smartindent = true
vim.opt.autoindent = true -- keep indentation from previous line

-- Enable break indent
vim.opt.breakindent = true

-- Always show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show line under cursor
vim.opt.cursorline = true

-- Store undos between sessions
vim.opt.undofile = true

-- Dont show the mode
vim.opt.showmode = false

-- Case insensitive search UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep SignColumn on by default
vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

vim.opt.termguicolors = true
