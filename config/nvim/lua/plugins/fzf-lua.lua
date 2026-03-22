return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {},
    keys = {
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            desc = "Find Files in Current Working Directory"
        },
        {
            "<leader>fg",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Find by grepping in the project directory"
        },
        {
            "<leader>fb",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "Find in open buffers"
        },
        {
            "<leader>fh",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "Find in NEOVIM HELP"
        },
        {
            "<leader>fp",
            function()
                local history = require("project_nvim.utils.history")
                local projects = history.get_recent_projects()

                require("fzf-lua").fzf_exec(projects, {
                    prompt = "Projects> ",
                    actions = {
                        ["default"] = function(selected)
                            vim.cmd("cd " .. selected[1])
                            print("Switched to " .. selected[1])
                        end,
                    },
                })
            end,
            desc = "Find in projects"
        },
         {
            "<leader>fk",
            function()
                require("fzf-lua").keymaps()
            end,
            desc = "[F]ind [K]eymaps",
        },
        {
            "<leader>fr",
            function()
                require("fzf-lua").resume()
            end,
            desc = "[F]ind [R]esume",
        },
    }
    ---@diagnostic enable: missing-fields
}
