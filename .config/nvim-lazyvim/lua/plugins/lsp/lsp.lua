return {
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
        { "<leader>l", group = "LSP" },
      },
    },
  },
}
