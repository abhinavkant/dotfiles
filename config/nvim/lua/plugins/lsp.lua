return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        opts = {
            automatic_installation = false,
            automatic_enable = false,
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local registry = require("mason-registry")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lsp_by_filetype = {
                cs = {
                    packages = { "omnisharp" },
                    servers = { "omnisharp" },
                },
                javascript = {
                    packages = { "typescript-language-server" },
                    servers = { "ts_ls" },
                },
                javascriptreact = {
                    packages = { "typescript-language-server" },
                    servers = { "ts_ls" },
                },
                lua = {
                    packages = { "lua-language-server" },
                    servers = { "lua_ls" },
                },
                ps1 = {
                    packages = { "powershell-editor-services" },
                    servers = { "powershell_es" },
                },
                psd1 = {
                    packages = { "powershell-editor-services" },
                    servers = { "powershell_es" },
                },
                psm1 = {
                    packages = { "powershell-editor-services" },
                    servers = { "powershell_es" },
                },
                python = {
                    packages = { "pyright", "ruff" },
                    servers = { "pyright", "ruff" },
                },
                sql = {
                    packages = { "sql-language-server" },
                    servers = { "sqlls" },
                },
                typescript = {
                    packages = { "typescript-language-server" },
                    servers = { "ts_ls" },
                },
                typescriptreact = {
                    packages = { "typescript-language-server" },
                    servers = { "ts_ls" },
                },
            }

            local configured_servers = {}
            local pending_installs = {}

            local function configure_server(server)
                if configured_servers[server] then
                    return
                end

                configured_servers[server] = true
                vim.lsp.config(server, {
                    capabilities = capabilities,
                })
            end

            local function all_packages_installed(packages)
                for _, package_name in ipairs(packages) do
                    local ok, package = pcall(registry.get_package, package_name)
                    if not ok or not package:is_installed() then
                        return false
                    end
                end

                return true
            end

            local function enable_servers(servers)
                for _, server in ipairs(servers) do
                    configure_server(server)
                    vim.lsp.enable(server)
                end
            end

            local function ensure_packages(spec)
                if all_packages_installed(spec.packages) then
                    enable_servers(spec.servers)
                    return
                end

                local callback_key = table.concat(spec.packages, ",")

                if pending_installs[callback_key] then
                    return
                end

                pending_installs[callback_key] = true

                for _, package_name in ipairs(spec.packages) do
                    local ok, package = pcall(registry.get_package, package_name)
                    if ok and not package:is_installed() then
                        package:once("install:success", function()
                            if all_packages_installed(spec.packages) then
                                pending_installs[callback_key] = nil
                                vim.schedule(function()
                                    enable_servers(spec.servers)
                                end)
                            end
                        end)

                        package:install()
                    end
                end
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
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

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("lsp-install-on-filetype", { clear = true }),
                callback = function(ev)
                    local spec = lsp_by_filetype[ev.match]
                    if not spec then
                        return
                    end

                    ensure_packages(spec)
                end,
            })
        end,
    },
}
