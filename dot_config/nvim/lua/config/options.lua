-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
-- Use the modern 'ruff' LSP instead of the legacy 'ruff_lsp'
vim.g.lazyvim_python_ruff = "ruff"

-- Use 'basedpyright' for faster type checking, or keep 'pyright'
vim.g.lazyvim_python_lsp = "pyright"

-- Schakel de bovenste tabline / bufferbalk volledig uit
vim.opt.showtabline = 0
