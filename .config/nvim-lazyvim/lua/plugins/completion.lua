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
  -- {
  --   "hrsh7th/nvim-cmp",
  --   config = function()
  --     local cmp = require("cmp")
  --     return {
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<CR>"] = function(fallback)
  --           cmp.abort()
  --           fallback()
  --         end,
  --         ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
  --         ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         -- ["<C-CR>"] = function(fallback)
  --         --   cmp.abort()
  --         --   fallback()
  --         -- end,
  --         ["<tab>"] = function(fallback)
  --           return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
  --         end,
  --       }),
  --     }
  --   end,
  -- },
}
