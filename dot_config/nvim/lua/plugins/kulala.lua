return {
  "mistweaverco/kulala.nvim",
  ft = { "http" },
  keys = {
    { "<leader>Rt", function() require("kulala").run() end, desc = "Send Request" },
    { "<leader>Ra", function() require("kulala").run_all() end, desc = "Send All Requests" },
    { "<leader>Re", function() require("kulala").set_selected_env() end, desc = "Select Environment" },
  },
  opts = {},
}
