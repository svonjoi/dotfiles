-- disable keys configuration inside LazyVim
return {
  {
    "stevearc/conform.nvim",
    keys = {
      -- { "<leader>cF", false, mode = { "i", "n", "s" } },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>sG", false, mode = { "i", "n", "s" } },
      { "<leader>sg", false, mode = { "i", "n", "s" } },
    },
  },
}
