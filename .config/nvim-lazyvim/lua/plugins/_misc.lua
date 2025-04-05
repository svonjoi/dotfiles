return {
  { "wakatime/vim-wakatime", lazy = false },
  {
    "tpope/vim-rsi",
  },
  {
    "almo7aya/openingh.nvim",
    keys = {
      {
        "<Leader>go",
        ":OpenInGHFileLines <CR>",
        { silent = true, noremap = true },
        desc = "open line in gh",
      },
    },
  },
}
