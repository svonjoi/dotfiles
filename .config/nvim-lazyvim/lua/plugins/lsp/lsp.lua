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
        "<leader>cF",
        "<cmd>Telescope lsp_document_symbols ignore_symbols=variable,property,method<cr>",
        desc = "doc-functions",
      },
      {
        "<leader>cM",
        "<cmd>Telescope lsp_document_symbols ignore_symbols=variable,property,function<cr>",
        desc = "docs-methods",
      },
    },
  },
}
