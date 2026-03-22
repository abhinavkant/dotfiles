return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                csharp = { "csharpier" }, -- 🔥 for C#
            },

            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true, -- 👈 important
            },
        },
    },
}
