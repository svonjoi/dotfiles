return {
  {
    "saghen/blink.cmp",
    enabled = true,
    opts = {
      -- https://github.com/Saghen/blink.cmp/issues/1412
      fuzzy = {
        implementation = "lua",
      },
      keymap = {
        -- https://cmp.saghen.dev/configuration/keymap.html#presets
        preset = "default",
        ["<C-y>"] = { "select_and_accept" },
      },
      sources = {
        -- lazydev спиздил с внутрянки
        default = { "lazydev", "lsp", "buffer", "snippets", "path" },
        per_filetype = {
          sql = { "snippets", "dadbod", "buffer" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
          -- add vim-dadbod-completion to your completion providers
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
  },
}
