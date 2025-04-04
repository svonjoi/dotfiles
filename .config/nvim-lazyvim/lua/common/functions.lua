-- i have to import this file to use this lua functions

function GetPlugList_()
  vim.print(require("lazy").plugins())

  -- local plugs = require("lazy").plugins()
  -- local jsonString = convertToJSON(plugs)

  -- File = io.open("test.txt", "w")
  -- File:write(jsonString)
  -- File:close()
end

function Print2buffer(something)
  -- vim.api.nvim_buf_set_lines(0, 0, 0, 0, vim.split(vim.inspect(vim), "\n"))
  vim.api.nvim_buf_set_lines(0, 0, 0, 0, vim.split(vim.inspect(something), "\n"))
end

-- vim.api.nvim_set_keymap("n", "gm", "<cmd>lua format_range_operator()<CR>", {noremap = true})

-- print table
P = function(v)
  print(vim.inspect(v))
  return v
end

function ShowActiveDebugSessions()
  local w = require("dap.ui.widgets")
  w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
end

function StatusActiveDebugSessions()
  local r = {}
  for i, v in pairs(require("dap").sessions()) do
    table.insert(r, v.config.name)
  end
  return r
end
