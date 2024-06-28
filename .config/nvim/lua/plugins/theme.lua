-- https://github.com/savq/melange-nvim
-- https://github.com/bluz71/vim-nightfly-colors
-- https://github.com/miikanissi/modus-themes.nvim
--
-- https://codeberg.org/shinyzero0/dotfiles/src/branch/guix/.config/guix-home/nvim/lua/plugins.d/Skins.lua
return {
  -- { "challenger-deep-theme/vim", config = true, lazy = true },
  -- { "bluz71/vim-nightfly-guicolor", lazy = true },
  { "nyoom-engineering/oxocarbon.nvim", lazy = true },
  { "dasupradyumna/midnight.nvim", lazy = true },
  { "miikanissi/modus-themes.nvim", config = true, lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true, opts = { contrast = "hard" } },
  { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
  -- { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox.nvim",
    },
  },
}
