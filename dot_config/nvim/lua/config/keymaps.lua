-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode with jk" })
-- Open Gemini CLI in een verticale split aan de rechterkant
vim.keymap.set("n", "<leader>ag", function()
  vim.cmd("vsplit")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(win, 60)
  vim.cmd("term gemini")
  vim.cmd("startinsert")
end, { desc = "Open Gemini CLI (sidebar)" })

vim.keymap.set("t", "jj", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Normal mode window navigation met Ctrl + pijltjestoetsen (naast Ctrl + hjkl)
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Ga naar linkervenster", remap = true })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Ga naar ondervenster", remap = true })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Ga naar bovenvenster", remap = true })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Ga naar rechtervenster", remap = true })

-- Terminal mode window navigation (zowel pijltjestoetsen als hjkl)
vim.keymap.set("t", "<C-Left>", "<cmd>wincmd h<cr>", { desc = "Terminal: ga naar linkervenster" })
vim.keymap.set("t", "<C-Down>", "<cmd>wincmd j<cr>", { desc = "Terminal: ga naar ondervenster" })
vim.keymap.set("t", "<C-Up>", "<cmd>wincmd k<cr>", { desc = "Terminal: ga naar bovenvenster" })
vim.keymap.set("t", "<C-Right>", "<cmd>wincmd l<cr>", { desc = "Terminal: ga naar rechtervenster" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Terminal: ga naar linkervenster" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Terminal: ga naar ondervenster" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Terminal: ga naar bovenvenster" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Terminal: ga naar rechtervenster" })

-- Insert mode window navigation
vim.keymap.set("i", "<C-Left>", "<Esc><C-w>h", { desc = "Insert: ga naar linkervenster" })
vim.keymap.set("i", "<C-Down>", "<Esc><C-w>j", { desc = "Insert: ga naar ondervenster" })
vim.keymap.set("i", "<C-Up>", "<Esc><C-w>k", { desc = "Insert: ga naar bovenvenster" })
vim.keymap.set("i", "<C-Right>", "<Esc><C-w>l", { desc = "Insert: ga naar rechtervenster" })
vim.keymap.set("i", "<C-h>", "<Esc><C-w>h", { desc = "Insert: ga naar linkervenster", nowait = true })
vim.keymap.set("i", "<C-l>", "<Esc><C-w>l", { desc = "Insert: ga naar rechtervenster", nowait = true })

-- -- Terminal mode buffer navigation (Shift)
-- vim.keymap.set("t", "<S-h>", "<C-\\><C-n><cmd>bprev<cr>", { desc = "Terminal: vorige buffer" })
-- vim.keymap.set("t", "<S-l>", "<C-\\><C-n><cmd>bnext<cr>", { desc = "Terminal: volgende buffer" })

-- -- Insert mode buffer navigation (Shift)
-- vim.keymap.set("i", "<S-h>", "<Esc><cmd>bprev<cr>", { desc = "Insert: vorige buffer" })
-- vim.keymap.set("i", "<S-l>", "<Esc><cmd>bnext<cr>", { desc = "Insert: volgende buffer" })
