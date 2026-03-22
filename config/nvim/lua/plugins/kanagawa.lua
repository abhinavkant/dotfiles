return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                compile = true,
                undercurl = true,
                commentStyle = { italic = true },
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                transparent = false,
                theme = "wave", -- wave | dragon | lotus
            })

            vim.cmd("colorscheme kanagawa")
        end,
        build = function()
            vim.cmd("KanagawaCompile");
        end
    },
}
