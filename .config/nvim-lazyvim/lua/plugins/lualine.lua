--TODO: FUCKING LUALING CONFIG IS BEING IGNORED WTF
return {

  "nvim-lualine/lualine.nvim",

  opts = function(_, opts)
    table.insert(opts.extensions, "fugitive")
    table.insert(opts.extensions, "man")
    table.insert(opts.extensions, "nvim-dap-ui")
    table.insert(opts.extensions, "nvim-tree")
    table.insert(opts.extensions, "quickfix")
    table.insert(opts.extensions, "toggleterm")

    opts.options.theme = "iceberg_dark"
  end,
}
-- return {
--   "nvim-lualine/lualine.nvim",
--   opts = {
--     options = {
--       -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
--       theme = "iceberg_dark",
--       -- globalstatus = true,
--       -- theme = "16color",
--       globalstatus = vim.o.laststatus == 3,
--       disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
--     },
--     extensions = {
--       "fugitive",
--       "fzf",
--       "man",
--       "nvim-dap-ui",
--       "nvim-tree",
--       "quickfix",
--       "toggleterm",
--     },
--     sections = {
--       lualine_x = {
--         {
--           function()
--             return " " .. require("dap").status()
--           end,
--           cond = function()
--             return package.loaded["dap"] and require("dap").status() ~= ""
--           end,
--           color = function()
--             return Snacks.util.color("Debug")
--           end,
--         },
--       },
--     },
--   },
--   dependencies = {
--     "nvim-tree/nvim-web-devicons",
--   },
-- }
