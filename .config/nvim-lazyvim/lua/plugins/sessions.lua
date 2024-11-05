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
    save_hook = function()
      -- https://github.com/gennaro-tedesco/nvim-possession/issues/32
      -- close terminal tabs as they can't be restored and break plugin
      -- local tabpage_count = vim.fn.tabpagenr("$") -- Get the number of tabpages
      -- for i = 1, tabpage_count do
      --   local win_ids = vim.api.nvim_tabpage_list_wins(i) -- Get window IDs in tabpage
      --   for _, win_id in ipairs(win_ids) do
      --     local bufnr = vim.api.nvim_win_get_buf(win_id) -- Get buffer number
      --     if vim.api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then -- Check if buffer is terminal
      --       vim.api.nvim_command(i .. "tabclose") -- Close the tabpage
      --       return
      --     end
      --   end
      -- end

      -- Get visible buffers
      -- local visible_buffers = {}
      -- for _, win in ipairs(vim.api.nvim_list_wins()) do
      --   visible_buffers[vim.api.nvim_win_get_buf(win)] = true
      -- end
      -- local buflist = vim.api.nvim_list_bufs()
      -- for _, bufnr in ipairs(buflist) do
      --   if visible_buffers[bufnr] == nil then -- Delete buffer if not visible
      --     vim.cmd("bd " .. bufnr)
      --   end
      -- end
    end,
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
