return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },

        patterns = {
          ".git",
          "package.json",
          "pyproject.toml",
          "Makefile",
          ".sln",        -- important for C#
        },

        show_hidden = true,
        silent_chdir = true,
      })
    end,
  },
}
