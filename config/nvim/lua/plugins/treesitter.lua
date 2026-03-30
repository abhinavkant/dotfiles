return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup()

    -- Ensure these parsers are installed
    require("nvim-treesitter").install({
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

        -- The new main branch no longer provides auto_install or automatic
        -- highlighting. This autocmd handles both: if a parser is missing,
        -- install it on demand, then enable tree-sitter highlighting.
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(ev.match) or ev.match

                -- Skip unsupported / virtual filetypes
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

                -- If parser isn't loaded yet, try to install it. install() is
                -- async and idempotent — already-installed parsers are skipped.
                if not pcall(vim.treesitter.language.inspect, lang) then
                    pcall(require("nvim-treesitter").install, { lang })
                end

                pcall(vim.treesitter.start)
            end,
        })
    end,
}
