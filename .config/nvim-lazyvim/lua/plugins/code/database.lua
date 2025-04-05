return {
  -- WARNING option --ssl-verify-server-cert is disabled, because of an insecure passwordless login.
  -- mariadb --ssl-verify-server-cert=false ...
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
  },
}
