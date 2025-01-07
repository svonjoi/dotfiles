--TODO: FUCKING LUALING CONFIG IS BEING IGNORED WTF
-- return {
--   "nvim-lualine/lualine.nvim",
--
--   opts = function(_, opts)
--     table.insert(opts.extensions, "fugitive")
--     table.insert(opts.extensions, "man")
--     table.insert(opts.extensions, "nvim-dap-ui")
--     table.insert(opts.extensions, "nvim-tree")
--     table.insert(opts.extensions, "quickfix")
--     table.insert(opts.extensions, "toggleterm")
--
--     opts.options.theme = "16color"
--   end,
-- }
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
      theme = "horizon",
      -- globalstatus = true,
      -- theme = "16color",
      globalstatus = vim.o.laststatus == 3,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
    },
    extensions = {
      "fugitive",
      "fzf",
      "man",
      "nvim-dap-ui",
      "nvim-tree",
      "quickfix",
      "toggleterm",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = {
        {
          require("noice").api.status.command.get,
          cond = require("noice").api.status.command.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.status.mode.get,
          cond = require("noice").api.status.mode.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.status.search.get,
          cond = require("noice").api.status.search.has,
          color = { fg = "#ff9e64" },
        },
        {
          function()
            return " " .. require("dap").status()
          end,
          cond = function()
            return package.loaded["dap"] and require("dap").status() ~= ""
          end,
          color = function()
            return { fg = "orange" }
          end,
        },
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
