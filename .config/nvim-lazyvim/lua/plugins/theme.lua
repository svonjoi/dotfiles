-- https://github.com/savq/melange-nvim
-- https://github.com/bluz71/vim-nightfly-colors
-- https://github.com/miikanissi/modus-themes.nvim
--
-- https://codeberg.org/shinyzero0/dotfiles/src/branch/guix/.config/guix-home/nvim/lua/plugins.d/Skins.lua
return {
  -- {
  --   "jordanbrauer/citylights.nvim",
  --   config = function()
  --     require("colorbuddy").colorscheme("citylights")
  --   end,
  -- },
  { "challenger-deep-theme/vim", config = true, lazy = false },
  {
    "nyoom-engineering/oxocarbon.nvim",
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
  },
  { "SethBarberee/challenger-deep.nvim", lazy = false },
  { "nyoom-engineering/oxocarbon.nvim", lazy = false },
  { "dasupradyumna/midnight.nvim", lazy = true },
  { "miikanissi/modus-themes.nvim", config = true, lazy = false },
  { "ellisonleao/gruvbox.nvim", lazy = false, opts = { contrast = "hard" } },
  { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
  { "pineapplegiant/spaceduck", priority = 1000, config = true, opts = {} },
  {
    "LazyVim/LazyVim",
    opts = {
      -- vim.cmd("colorscheme gruvbox"),
      colorscheme = "gruvbox",
    },
  },
  -- { "bluz71/vim-nightfly-guicolor", lazy = true },
  -- { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
}
