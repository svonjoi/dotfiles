return {
  "nvim-telescope/telescope.nvim",
  keys = {},
  dependencies = {
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
  },
  opts = function()
    local actions = require("telescope.actions")

    return {
      pickers = {
        -- find_files = {
        --   theme = "dropdown",
        -- },
        buffers = {
          theme = "dropdown",
          -- не воркает
          preview = false,
          mappings = {
            i = {
              -- ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
              ["<c-d>"] = actions.delete_buffer,
            },
          },
        },
      },
    }
  end,
}
