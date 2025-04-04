-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.winbar = "%=%m %f"

-- transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- theme
vim.opt.background = "dark" -- set this to dark or light
-- vim.cmd("colorscheme oxocarbon")
-- vim.cmd.colorscheme("oxocarbon")

-- https://github.com/jedrzejboczar/possession.nvim/issues/19
-- vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  command = "normal zx",
})
