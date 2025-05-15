-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "php", "js" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- TODO: https://github.com/calebdw/dotfiles/blob/690db485c24594d01db11b16bb80c77dfa414ed2/.config/nvim/lua/calebdw/plugins/conform.lua#L26C1-L37C9

-- :NullLsInfo ???????????

return {
  -- {
  --   "nvimtools/none-ls.nvim",
  --   enabled = false,
  -- },
  {
    "stevearc/conform.nvim",
    -- enabled = false,
    opts = {
      -- NOTE: setting this (and installing corresponding binaries from mason) reemplaces lsp formatters
      -- TODO: does formatters respect .editorconfig?
      formatters_by_ft = {
        sql = { "sqlfmt" },
        mysql = { "sqlfmt" },
        json = { "prettierd", "jq", stop_after_first = true },
        markdown = { "prettierd" },
        yaml = { "yamlfmt" },
        lua = { "stylua" },
        javascript = { "biome" },
        typescript = { "biome" },
        xml = { "xmlformatter" },

        -- WARNING: after updating via mason it stops working
        -- TODO: [setup exacutable in docker container](https://github.com/stevearc/conform.nvim/issues/669)
        --
        -- falling back to lsp formatter...
        php = { "prettierd", stop_after_first = true }, -- easy-coding-standard
      },
      -- formatters_by_ft = {
      --   blade = { "prettier", "blade-formatter", stop_after_first = true  },
      --   javascript = { "prettierd", "prettier",  },
      --   php = { "pint", "phpcbf", "php_cs_fixer",  },
      --   rust = { "rustfmt",  },
      --   ["*"] = { "injected" },
      -- },
    },
  },
}
