vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })

--vim.keymap.set("n", "<leader>i", vim.lsp.buf.format, { desc = "Format file" })

vim.keymap.set("n", "<leader>i", function()
  require("conform").format({ async = true })
end, { desc = "Format file" })
