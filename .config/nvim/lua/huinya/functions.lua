function GetPlugList_()
  vim.print(require("lazy").plugins())

  -- local plugs = require("lazy").plugins()
  -- local jsonString = convertToJSON(plugs)

  -- File = io.open("test.txt", "w")
  -- File:write(jsonString)
  -- File:close()
end
