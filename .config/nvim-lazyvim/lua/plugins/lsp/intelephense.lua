return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- @type lspconfig.options
      servers = {
        intelephense = {
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
}
