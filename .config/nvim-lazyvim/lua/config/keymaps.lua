-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = Util.safe_keymap_set

--~~~~> svonjoi
-- remove default LazyVim keymaps
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "[b")
vim.keymap.del("n", "]b")
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>`")

-- todo: neotree mapping
-- map({ "n" }, "<leader>f1", '<cmd>let @+=expand("%")<cr><esc>', { desc = "copy relative filepath" })
-- map({ "n" }, "<leader>f2", '<cmd>let @+=expand("%:p")<cr><esc>', { desc = "copy absolute filepath" })
-- map({ "n" }, "<leader>f3", '<cmd>let @+=expand("%:p:h")<cr><esc>', { desc = "copy dirname" })
-- map({ "n" }, "<leader>f4", '<cmd>let @+=expand("%:t")<cr><esc>', { desc = "copy filename" })
