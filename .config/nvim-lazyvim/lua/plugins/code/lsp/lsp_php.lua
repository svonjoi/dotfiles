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
                phpVersion = "7.4",
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
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "kevinhwang91/promise-async",
    },
    cmd = { "Laravel" },
    keys = {
      { "<leader>lla", ":Laravel artisan<cr>" },
      { "<leader>llr", ":Laravel routes<cr>" },
      { "<leader>llm", ":Laravel related<cr>" },
    },
    event = { "VeryLazy" },
    opts = {},
    config = true,
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
