require("which-key").add({
  -- buffer = true,
  mode = { "n", "v" },
  { "<Leader>gr", group = "github" },
  { "<Leader>gri", group = "issues" },
})

return {
  {
    -- `gh auth login`
    -- https://github.com/nvim-telescope/telescope-github.nvim
    "nvim-telescope/telescope-github.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<Leader>gria", "<cmd>Telescope gh issues limit=300<cr>", desc = "all" },
      { "<Leader>grim", "<cmd>Telescope gh issues assignee=@me<cr>", desc = "assignee=me" },
      { "<Leader>gri1", "<cmd>Telescope gh issues assignee=shinyzero00<cr>", desc = "assignee=shiny" },
      { "<Leader>gri2", "<cmd>Telescope gh issues assignee=baderbuu9<cr>", desc = "assignee=bader" },
    },
  },
  {
    "almo7aya/openingh.nvim",
    keys = {
      {
        "<Leader>gro",
        ":OpenInGHFileLines <CR>",
        { silent = true, noremap = true },
        desc = "open line in gh",
      },
    },
  },
}
