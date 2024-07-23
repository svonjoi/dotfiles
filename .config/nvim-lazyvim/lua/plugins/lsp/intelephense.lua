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
