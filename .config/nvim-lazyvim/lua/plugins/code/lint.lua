-- Show linters for the current buffer's file type
vim.api.nvim_create_user_command("LintInfo", function()
  local filetype = vim.bo.filetype
  local linters = require("lint").linters_by_ft[filetype]

  if linters then
    print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
  else
    print("No linters configured for filetype: " .. filetype)
  end
end, {})

-- require("lint").try_lint("pylint")
-- require('lint').try_lint()

return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local more_opts = {
        -- Event to trigger linters
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
          fish = { "fish" },
          php = { "phpstan" },

          -- javascript = { "biomejs" },

          -- Use the "*" filetype to run linters on all filetypes.
          -- ['*'] = { 'global linter' },
          -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
          -- ['_'] = { 'fallback linter' },
          -- ["*"] = { "typos" },

          -- TODO: if enabled, diagnostics are duplicated with vstls..
          -- idk how to disable vstls diagnostics without disable entire lsp
          --
        },
        linters = {
          -- https://github.com/svonjoi/dotfiles/issues/1#issuecomment-2849379162
          phpstan = {
            cmd = function()
              local executable = vim.fn.fnamemodify("phpstan.sh", ":p")
              return vim.loop.fs_stat(executable) and executable or error("executable not found: " .. executable)

              -- local bin = "phpstan"
              -- local local_bin = vim.fn.fnamemodify("vendor/bin/" .. bin, ":p")
              -- return vim.loop.fs_stat(local_bin) and local_bin or bin
            end,
          },
        },
      }

      return vim.tbl_deep_extend("force", opts or {}, more_opts)
    end,
  },
}
