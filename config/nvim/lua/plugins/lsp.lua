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
                "omnisharp",
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

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
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

            -- enable servers
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("omnisharp")
        end,
    },
}
