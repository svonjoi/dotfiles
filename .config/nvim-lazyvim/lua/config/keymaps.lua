-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- remove default LazyVim keymaps
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "[b")
vim.keymap.del("n", "]b")
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>`")

vim.keymap.del("n", "<leader>l") -- lazy.nvim
vim.keymap.del("n", "<leader>L") -- lazyvim changelog

-- TODO: хули не пашет?
-- vim.keymap.del("n", "<C-w>q")

-- set keys
vim.keymap.set("n", "<leader>P", "<cmd>Lazy<cr>", { desc = "Lazy" })

vim.keymap.set("n", "<leader>;", function()
  LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })

-- vim.keymap.set("n", "<leader>sx", require("telescope.builtin").resume, {
--   noremap = true,
--   silent = true,
--   desc = "Resume",
-- })

-- todo: neotree mapping
-- map({ "n" }, "<leader>f1", '<cmd>let @+=expand("%")<cr><esc>', { desc = "copy relative filepath" })
-- map({ "n" }, "<leader>f2", '<cmd>let @+=expand("%:p")<cr><esc>', { desc = "copy absolute filepath" })
-- map({ "n" }, "<leader>f3", '<cmd>let @+=expand("%:p:h")<cr><esc>', { desc = "copy dirname" })
-- map({ "n" }, "<leader>f4", '<cmd>let @+=expand("%:t")<cr><esc>', { desc = "copy filename" })

-- DO NOT USE THIS IN YOU OWN CONFIG!!; use `vim.keymap.set` instead
-- This file is automatically loaded by lazyvim.config.init
-- local Util = require("lazyvim.util")
-- local map = Util.safe_keymap_set
