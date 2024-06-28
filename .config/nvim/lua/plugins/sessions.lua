return {
  "gennaro-tedesco/nvim-possession",
  dependencies = {
    "ibhagwan/fzf-lua",
  },
  opts = {
    autoswitch = {
      -- autosaves the previous session and deletes all its buffers before switching to a new one
      enable = true,
    },
  },
  init = function()
    local possession = require("nvim-possession")
    vim.keymap.set("n", "<leader>ie", function()
      possession.list()
    end, { desc = "list sessions" })
    vim.keymap.set("n", "<leader>in", function()
      possession.new()
    end, { desc = "new session" })
    vim.keymap.set("n", "<leader>iu", function()
      possession.update()
    end, { desc = "update session" })
    vim.keymap.set("n", "<leader>id", function()
      possession.delete()
    end, { desc = "delete session" })
  end,
}
