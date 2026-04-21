vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })

--vim.keymap.set("n", "<leader>i", vim.lsp.buf.format, { desc = "Format file" })

-- Copy absolute path
vim.keymap.set("n", "<leader>pa", ":let @+ = expand('%:p')<CR>", { desc = "Copy absolute path" })

-- Copy relative path
vim.keymap.set("n", "<leader>pr", ":let @+ = expand('%')<CR>", { desc = "Copy relative path" })

-- Copy filename only
vim.keymap.set("n", "<leader>pf", ":let @+ = expand('%:t')<CR>", { desc = "Copy filename" })


vim.keymap.set("n", "<leader>i", function()
  require("conform").format({ async = true })
end, { desc = "Format file" })
