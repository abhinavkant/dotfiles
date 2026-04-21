return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup()

        local parser_by_filetype = {
            cs = "c_sharp",
            javascriptreact = "tsx",
            python = "python",
            sh = "bash",
            typescriptreact = "tsx",
            zsh = "bash",
        }

        treesitter.install({
            "bash",
            "c",
            "c_sharp",
            "css",
            "diff",
            "git_rebase",
            "gitcommit",
            "gitignore",
            "html",
            "javascript",
            "json",
            "just",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "rust",
            "sql",
            "ssh_config",
            "tmux",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
        })

        vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
            group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
            callback = function(ev)
                local buf = ev.buf
                local filetype = vim.bo[buf].filetype
                if filetype == "" then
                    return
                end

                local lang = parser_by_filetype[filetype] or vim.treesitter.language.get_lang(filetype) or filetype
                local skip = {
                    ["conform-info"] = true,
                    ["help"] = true,
                    ["lazy"] = true,
                    ["mason"] = true,
                    ["lspinfo"] = true,
                }

                if skip[lang] then
                    return
                end

                local function start_highlighting()
                    if vim.api.nvim_buf_is_valid(buf) then
                        pcall(vim.treesitter.start, buf, lang)
                    end
                end

                if pcall(vim.treesitter.language.inspect, lang) then
                    start_highlighting()
                    return
                end

                local ok, task = pcall(treesitter.install, { lang })
                if not ok then
                    return
                end

                task:await(function(err)
                    if err then
                        return
                    end

                    vim.schedule(start_highlighting)
                end)
            end,
        })
    end,
}
