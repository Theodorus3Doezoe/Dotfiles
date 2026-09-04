return {
  {
    import = "lazyvim.plugins.extras.editor.mini-files",
  },
  {
    "nvim-mini/mini.files",
    lazy = false,
    opts = {
      mappings = {
        go_in = "<Right>",
        go_in_plus = "<CR>",
        go_out = "<Left>",
        go_out_plus = "<S-Left>",
      },
      options = {
        use_as_default_explorer = true,
      },
    },
    keys = {
      {
        "<leader>-",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (directory van huidig bestand)",
      },
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (directory van huidig bestand)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
  },
}
