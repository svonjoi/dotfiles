-- EDITOR
vim.g.editorconfig = true -- default true
-- vim.opt.expandtab = true -- Use spaces instead of tabs
-- vim.opt.shiftround = true -- Round indent
-- vim.opt.tabstop = 2 -- Number of spaces tabs count for
-- vim.opt.shiftwidth = 2 -- Size of an indent

return {
  -- this play bad with midnight theme; instead enabled indent-blankline.nvim from extras
  -- https://www.lazyvim.org/extras/ui/indent-blankline#snacksnvim
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },
  {
    "tpope/vim-rsi",
  },
  {
    "FotiadisM/tabset.nvim",
    event = "BufReadPre",
    config = function()
      require("tabset").setup({
        defaults = {
          tabwidth = 4,
          expandtab = true,
        },
        languages = {
          {
            filetypes = { "lua", "yaml" },
            config = {
              tabwidth = 2,
            },
          },
          {
            filetypes = { "php" },
            config = {
              tabwidth = 2,
            },
          },
          go = {
            tabwidth = 4,
            expandtab = false,
          },
          {
            filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml" },
            config = {
              tabwidth = 2,
            },
          },
        },
      })
    end,
  },
}
