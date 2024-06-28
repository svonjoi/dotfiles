return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
          },
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      servers = {
        bashls = {
          -- npi if this works. idk how to see the REAL server configuration in real time
          settings = {
            bashIde = {
              globPattern = "*@(.sh|.inc|.bash|.command)",
            },
            enableSourceErrorDiagnostics = true,
          },
        },
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        tsserver = {
          settings = {
            javascript = {
              autoClosingTags = false,
              format = {
                enable = false,
              },
            },
          },
        },
        -- сука нерабочая
        intelephense = {
          settings = {
            -- https://github.com/bmewburn/vscode-intelephense/issues/2003
            -- format = {
            --   enable = "false",
            -- },
            -- on_init = function(client)
            --   client.server_capabilities.documentFormattingProvider = false
            -- end,
            -- пока буду на phpactor, потому что не могу отключить format on save
            -- конфигурация сервера не работает; посмотреть параметры сервера в рантайме
            -- 1.- способ print() параметры сервера в рантайме
            -- :lua print(vim.inspect(require("lspconfig").intelephense.manager.config))
            -- в пагере скролл скривой сука нихуя не понятно
            -- 2.- способ отключил диагностику, перезапустил сервер, а диагностика все равно пашет
            --
            intelephense = {
              compatibility = {
                correctForArrayAccessArrayAndTraversableArrayUnionTypes = false,
              },
              -- diagnostics = {
              --   enable = false,
              -- },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- https://github.com/LazyVim/LazyVim/issues/249
        tsserver = function(_, opts)
          opts.capabilities.documentFormattingProvider = false
        end,
        -- eslint = function(_, opts)
        --   opts.capabilities.documentFormattingProvider = true
        -- end,

        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
