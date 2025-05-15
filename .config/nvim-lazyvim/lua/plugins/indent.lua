return {
  -- this play bad with midnight theme; instead enabled indent-blankline.nvim from extras
  -- https://www.lazyvim.org/extras/ui/indent-blankline#snacksnvim
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },
}

-- return {
--   "lukas-reineke/indent-blankline.nvim",
--   opts = function()
--     local highlights = {
--       "CursorColumn",
--       "Whitespace",
--     }
--     return {
--       indent = {
--         highlight = highlights,
--         char = "│",
--         tab_char = "│",
--       },
--       -- scope = { show_start = false, show_end = false },
--       scope = { highlight = highlights },
--     }
--   end,
-- }
