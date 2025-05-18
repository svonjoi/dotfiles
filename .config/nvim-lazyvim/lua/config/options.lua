-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.winbar = "%=%m %f"

-- transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- vim.g.lazyvim_cmp = "nvim-cmp"

vim.opt.scrolloff = 6 -- Lines of context
vim.opt.sidescrolloff = 8 -- Columns of context

-- theme
vim.opt.background = "dark" -- set this to dark or light
-- vim.cmd("colorscheme oxocarbon")
-- vim.cmd.colorscheme("oxocarbon")

-- https://github.com/jedrzejboczar/possession.nvim/issues/19
-- vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp"
-- UOD. фолдит папки в neotree после удаления файла/папки
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "*" },
--   command = "normal zx",
-- })

-- configured through nvim-lspconfig
-- vim.diagnostic.config({
--   virtual_text = false,
--   underline = false,
--   -- virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
--   signs = { severity = { min = vim.diagnostic.severity.ERROR } },
--   underline = { severity = { min = vim.diagnostic.severity.ERROR } },
--   float = {
--     severity = { min = vim.diagnostic.severity.WARN },
--   },
-- })
