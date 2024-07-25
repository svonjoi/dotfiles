-- disable keys configuration inside LazyVim
-- maybe its a luck that this file is loaded before my lua files that contains the same keys?
return {
  {
    "stevearc/conform.nvim",
    keys = {
      { "<leader>cf", false, mode = { "i", "n", "s" } },
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
