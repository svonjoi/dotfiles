return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    -- enabled = false,
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    init = function()
      -- install treesitter parser for earch filetype
      vim.filetype.add({
        -- каждый доп ext надо устанавливать `:TSInstall sxhkdrc` или засунуть в ensure_installed
        extension = {
          caddy = "caddy",
          kdl = "kdl",
          tmux = "tmux",
          -- xaml = "xml",
          -- nu = "nu",
          -- axaml = "xml",
          -- scrbl = "racket",
        },
        filename = {
          -- [".guix-channel"] = "scheme",
          -- ["flake.lock"] = "json",
          -- ["run"] = "sh",
          -- [".kdl"] = "kdl",
          [".envrc"] = "sh",
          [".txt"] = "sh",
          ["sxhkdrc"] = "sxhkdrc",
          ["Caddyfile"] = "caddy",
        },
        pattern = {
          [ [[.*/etc/wireguard/.*%.conf]] ] = "confini",
        },
      })
    end,
    dependencies = {
      "LiadOz/nvim-dap-repl-highlights",
      -- {
      --   "nvim-treesitter/nvim-treesitter-textobjects",
      -- },
      -- спиздил для пыха
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
          custom_calculation = function(_, language_tree)
            if vim.bo.filetype == "blade" and language_tree._lang ~= "javascript" and language_tree._lang ~= "php" then
              return "{{-- %s --}}"
            end
          end,
        },
      },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true }, -- Needed because treesitter highlight turns off autoindent for php files
      ensure_installed = {
        "php",
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "kdl",
        "sxhkdrc",
        "dap_repl",
        "php_only",
        "caddy",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
    },

    -- config = function(_, opts)
    --   TODO:
    --   require("nvim-dap-repl-highlights").setup()
    --
    --   -- установить blade для пыха
    --   ------@class ParserInfo[]
    --   ---local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --   ---parser_config.blade = {
    --   ---  install_info = {
    --   ---    url = "https://github.com/EmranMR/tree-sitter-blade",
    --   ---    files = {
    --   ---      "src/parser.c",
    --   ---      -- 'src/scanner.cc',
    --   ---    },
    --   ---    branch = "main",
    --   ---    generate_requires_npm = true,
    --   ---    requires_generate_from_grammar = true,
    --   ---  },
    --   ---  filetype = "blade",
    --   ---}
    --
    --   -- require("nvim-treesitter.configs").setup(opts)
    -- end,
  },

  -- Show context of the current function
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    enabled = true,
    opts = { mode = "cursor", max_lines = 3 },
    keys = {
      {
        "<leader>ut",
        function()
          local Util = require("lazyvim.util")
          local tsc = require("treesitter-context")
          tsc.toggle()
          if Util.inject.get_upvalue(tsc.toggle, "enabled") then
            Util.info("Enabled Treesitter Context", { title = "Option" })
          else
            Util.warn("Disabled Treesitter Context (нахуй)", { title = "Option" })
          end
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
}
