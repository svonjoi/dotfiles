return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = false,
        update_in_insert = false,
        virtual_text = false,
        -- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.Opts.VirtualText
        -- virtual_text = {
        --   spacing = 4,
        --   source = "if_many",
        --   prefix = "●",
        --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        --   -- prefix = "icons",
        -- },
        float = {
          border = "rounded",
          source = "always",
        },
        signs = {
          severity_sort = true,
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {
      save_in_cmd_history = false,
    },
    keys = {
      {
        "<leader>rn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Incremental Rename",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>lF",
        "<cmd>Telescope lsp_document_symbols symbols=function<cr>",
        desc = "document functions",
      },
      {
        "<leader>lM",
        "<cmd>Telescope lsp_document_symbols symbols=method<cr>",
        desc = "document methods",
      },
      {
        "<leader>ld",
        "<cmd>Telescope lsp_definitions<cr>",
        desc = "definitions",
      },
      {
        "<leader>li",
        "<cmd>Telescope lsp_implementations<cr>",
        desc = "implementations",
      },
      {
        "<leader>lt",
        "<cmd>Telescope <cr>",
        desc = "type definitions",
      },
      {
        "<leader>lt",
        "<cmd>Telescope lsp_type_definitions<cr>",
        desc = "type definitions",
      },
      {
        "<leader>lD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "telescope diagnostics",
      },
      {
        "<leader>lR",
        "<cmd>Telescope lsp_references<cr>",
        desc = "references",
      },
      {
        "<leader>lw",
        "<cmd>Telescope lsp_workspace_symbols<cr>",
        desc = "lsp_workspace_symbols",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>l", group = "lsp" },
      },
    },
  },
}
