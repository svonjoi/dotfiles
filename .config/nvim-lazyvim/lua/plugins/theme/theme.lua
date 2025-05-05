-- https://github.com/savq/melange-nvim
-- https://github.com/bluz71/vim-nightfly-colors
-- https://github.com/miikanissi/modus-themes.nvim
-- https://github.com/sho-87/kanagawa-paper.nvim
-- https://github.com/water-sucks/darkrose.nvim
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
  -- { "pineapplegiant/spaceduck", priority = 1000, config = true, opts = {} },
  {
    -- "water-sucks/darkrose.nvim",
    "svonjoi/dark.nvim",
    dev = true,
    lazy = false,
    priority = 1000,
    opts = {
      -- Override colors
      colors = {
        -- orange = "#F87757",
        -- pink = "red",
        -- dark_red = "#fff",
      },
      -- Override existing or add new highlight groups
      overrides = function(c)
        return {
          Class = { fg = c.magenta },
          ["@variable"] = { fg = c.fg_dark },
        }
      end,
      -- Styles to enable or disable
      styles = {
        bold = true, -- Enable bold highlights for some highlight groups
        italic = true, -- Enable italic highlights for some highlight groups
        underline = true, -- Enable underline highlights for some highlight groups
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- vim.cmd("colorscheme gruvbox"),
      -- SPACEDUCK causa lualine error
      colorscheme = "darkrose",
    },
  },
  -- { "bluz71/vim-nightfly-guicolor", lazy = true },
  -- { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
}
