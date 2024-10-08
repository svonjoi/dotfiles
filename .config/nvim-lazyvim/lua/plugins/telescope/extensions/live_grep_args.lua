return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-telescope/telescope-live-grep-args.nvim" },
  optional = true,

  opts = function(_, opts)
    local lga_actions = require("telescope-live-grep-args.actions")

    if opts.extensions == nil then
      opts.extensions = {}
    end

    opts.extensions.live_grep_args = {
      mappings = {
        i = { ["<c-k>"] = lga_actions.quote_prompt({ postfix = " --iglob *" }) },
      },
    }
  end,

  keys = {
    { "<leader>sg", "<cmd>Telescope live_grep_args<cr>", desc = "Grep (with args)" },
  },
}
