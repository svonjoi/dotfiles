return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- "phpactor",
        "intelephense",
      },
    },
  },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  --
  -- add pyright to lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   ---@class PluginLspOpts
  --   opts = {
  --     ---@type lspconfig.options
  --     servers = {
  --       -- pyright will be automatically installed with mason and loaded with lspconfig
  --       -- pyright = {},
  --       -- phpactor
  --       -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#phpactor
  --     },
  --   },
  -- },
  --
  -- lua lsp?
  -- https://neovim.discourse.group/t/how-to-suppress-warning-undefined-global-vim/1882/13
  { "folke/neodev.nvim", opts = {} },
  -- install phpactor as standalone nvim plugin
  -- https://github.com/gbprod/phpactor.nvim/issues/13
  -- {
  --   "gbprod/phpactor.nvim",
  --   build = function()
  --     require("phpactor.handler.update")()
  --   end,
  -- },
}
