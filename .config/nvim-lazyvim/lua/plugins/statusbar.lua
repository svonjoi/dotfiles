-- это динамическое значение и нужно чтобы оно обновлялось
local function session_name()
  return require("possession.session").get_session_name() or ""
end

local function linters()
  local linters = require("lint").get_running()
  if #linters == 0 then
    return ""
  end
  -- return "󱉶 " .. table.concat(linters, ", ")
  local unique_linters = {}
  local seen = {}
  for _, linter in ipairs(linters) do
    if not seen[linter] then
      table.insert(unique_linters, linter)
      seen[linter] = true
    end
  end

  return " " .. table.concat(unique_linters, ", ")
end

local function formatters()
  -- https://github.com/nvim-lualine/lualine.nvim/discussions/1153
  -- Check if 'conform' is available
  local status, conform = pcall(require, "conform")
  if not status then
    return "Conform not installed"
  end

  local lsp_format = require("conform.lsp_format")

  -- Get formatters for the current buffer
  local formatters = conform.list_formatters_for_buffer()
  if formatters and #formatters > 0 then
    local formatterNames = {}

    for _, formatter in ipairs(formatters) do
      table.insert(formatterNames, formatter)
    end

    return "󰷈 " .. table.concat(formatterNames, " ")
  end

  -- Check if there's an LSP formatter
  local bufnr = vim.api.nvim_get_current_buf()
  local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

  if not vim.tbl_isempty(lsp_clients) then
    return "󰷈 LSP Formatter"
  end

  return ""
end

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
          formatters,
        },
        {
          linters,
        },
        {
          function()
            if vim.tbl_isempty(StatusActiveDebugSessions()) then
              return ""
            end
            return " " .. table.concat(StatusActiveDebugSessions(), "  ")
          end,
          cond = function()
            return package.loaded["dap"] and StatusActiveDebugSessions() ~= ""
          end,
          color = function()
            return { fg = "orange" }
          end,
        },
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_y = {
        {
          session_name,
          color = { fg = "grey" },
        },
        "progress",
      },
      lualine_z = { "location" },
    },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
