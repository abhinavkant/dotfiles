return {
    -- Mason (unchanged)
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    -- Mason bridge
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "csharp_ls",
                "sqlls",
            },
            automatic_installation = true,
            automatic_enable = true,
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- 👈 THIS is missing
            "L3MON4D3/LuaSnip",
        },
    },
    -- LSP (NEW WAY)
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- keymaps on attach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover" })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "Go to references" })
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename" })
                    vim.keymap.set(
                        "n",
                        "<leader>ca",
                        vim.lsp.buf.code_action,
                        { buffer = args.buf, desc = "code action" }
                    )
                end,
            })

            -- capabilities (for autocomplete)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- configure servers
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
            })

            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
            })

            vim.lsp.config("omnisharp", {
                capabilities = capabilities,
            })

            vim.lsp.config("sqlls", {
                capabilities = capabilities,
            })

            -- enable servers
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("omnisharp")
            vim.lsp.enable("sqlls")
        end,
    },
}
