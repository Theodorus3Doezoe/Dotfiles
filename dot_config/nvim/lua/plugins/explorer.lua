return {
  -- Deactiveer snacks explorer en de bijbehorende keymaps (<leader>e / <space>e)
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        enabled = false,
      },
    },
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
      { "<leader>fe", false },
      { "<leader>fE", false },
    },
  },
  -- Deactiveer neo-tree voor het geval deze als extra actief wordt
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}
