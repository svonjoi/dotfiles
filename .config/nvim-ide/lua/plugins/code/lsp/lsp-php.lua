return {
  {
    "jwalton512/vim-blade",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- @type lspconfig.options
      servers = {
        intelephense = {
          -- format = {
          --   enable = false,
          -- },
          filetypes = { "php", "blade" },
          settings = {
            intelephense = {
              diagnostics = {
                undefinedProperties = false,
              },
              filetypes = { "php", "blade" },
              files = {
                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                maxSize = 5000000,
                exclude = {
                  -- дефолтная дрисня
                  "**/.git/**",
                  "**/.svn/**",
                  "**/.hg/**",
                  "**/CVS/**",
                  "**/.DS_Store/**",
                  "**/node_modules/**",
                  "**/bower_components/**",
                  "**/vendor/**/{Tests,tests}/**",
                  "**/.history/**",
                  "**/vendor/**/vendor/**",
                  -- от меня
                  "**/.dist",
                },
              },
              environment = {
                phpVersion = "8.2",
              },
            },
          },
          -- keys = {
          --   {
          --     "<leader>cF",
          --     "<cmd>Telescope lsp_document_symbols ignore_symbols=variable,property,method<cr>",
          --     desc = "Document methods",
          --   },
          -- },
        },
      },
    },
  },
  {
    "adibhanna/laravel.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>la", ":Artisan<cr>", desc = "Laravel Artisan" },
      { "<leader>lc", ":Composer<cr>", desc = "Composer" },
      { "<leader>lr", ":LaravelRoute<cr>", desc = "Laravel Routes" },
      { "<leader>lm", ":LaravelMake<cr>", desc = "Laravel Make" },
    },
    config = function()
      require("laravel").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>ll", group = "Laravel" },
      },
    },
  },
}
