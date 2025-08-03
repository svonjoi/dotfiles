require("which-key").add({
  mode = { "n", "v" },
  { "<Leader>i", group = "session" },
})

return {
  "jedrzejboczar/possession.nvim",
  opts = {
    -- session_dir = (Path:new(vim.fn.stdpath("data")) / "possession"):absolute(),
    silent = false,
    load_silent = true,
    debug = false,
    logfile = false,
    prompt_no_cr = false,
    autosave = {
      current = true, -- or fun(name): boolean
      cwd = false, -- or fun(): boolean
      tmp = false, -- or fun(): boolean
      tmp_name = "tmp", -- or fun(): string
      on_load = true,
      on_quit = true,
    },
    autoload = "auto_cwd", -- or 'last' or 'auto_cwd' or 'last_cwd' or fun(): string
    commands = {
      save = "PossessionSave",
      load = "PossessionLoad",
      save_cwd = "PossessionSaveCwd",
      load_cwd = "PossessionLoadCwd",
      rename = "PossessionRename",
      close = "PossessionClose",
      delete = "PossessionDelete",
      show = "PossessionShow",
      list = "PossessionList",
      list_cwd = "PossessionListCwd",
      migrate = "PossessionMigrate",
    },
    hooks = {
      before_save = function(name)
        return {}
      end,
      after_save = function(name, user_data, aborted) end,
      before_load = function(name, user_data)
        return user_data
      end,
      after_load = function(name, user_data)
        if name == "tunuve" then
          -- TODO: :help indentexpr
          vim.cmd("TSDisable indent javascript")
          print("TS indentation for js: DISABLED")
          vim.cmd("TSEnable indent php")
          print("TS indentation for php: ENABLED")
        end

        if name == "dotfiles" then
          local opts = {
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
            filesystem = {
              bind_to_cwd = false,
              follow_current_file = { enabled = true },
              use_libuv_file_watcher = true,
              -- :h neo-tree-filtered-items
              filtered_items = {
                visible = false, -- when true, they will just be displayed differently than normal items
                hide_dotfiles = true,
                hide_gitignored = true,
                hide_by_name = {
                  ".DS_Store",
                  "thumbs.db",
                  --"node_modules",
                },
                hide_by_pattern = {
                  "/home/morke/*",
                  -- "*/.config/*",
                  --".gitignored",
                },
                always_show_by_pattern = { -- uses glob style patterns
                  "*/.config",
                  "*/.config/scripts",
                  "*/.config/scripts/*",
                  "*/.config/scripts_",
                  "*/.config/scripts_/*",
                  "*/.config/bat",
                  "*/.config/bat/*",
                  "*/.config/dunst",
                  "*/.config/dunst/*",
                  "*/.config/i3",
                  "*/.config/i3/*",
                  "*/.config/keyd",
                  "*/.config/keyd/*",
                  "*/.config/kitty",
                  "*/.config/kitty/*",
                  "*/.config/nvim-kickstart",
                  "*/.config/nvim-kickstart/*",
                  "*/.config/nvim-lazyvim",
                  "*/.config/nvim-lazyvim/*",
                  "*/.config/polybar",
                  "*/.config/polybar/*",
                  "*/.config/qutebrowser",
                  "*/.config/qutebrowser/*",
                  "*/.config/ranger",
                  "*/.config/ranger/*",
                  "*/.config/sxhkd",
                  "*/.config/sxhkd/*",
                  "*/.config/zellij",
                  "*/.config/zellij/*",
                  "*/.config/sioyek",
                  "*/.config/sioyek/*",
                  "*/.config/picom.conf",
                  "*/.config/lazydocker/*",
                  "*/.config/lazygit/*",
                  ".emacs",
                  ".zshrc",
                  -- "README.md",
                },
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                  --".DS_Store",
                  --"thumbs.db",
                },
                never_show_by_pattern = { -- uses glob style patterns
                  --".null-ls_*",
                },
              },
            },
            commands = {
              -- спиздил https://github.com/AstroNvim/AstroNvim/blob/6d5750bb4fbefeb816bf6d9d088df72dfefb9724/lua/plugins/neo-tree.lua#L73-L105
              copy_selector = function(state)
                local node = state.tree:get_node()
                local filepath = node:get_id()
                local filename = node.name
                local modify = vim.fn.fnamemodify

                local vals = {
                  ["BASENAME"] = modify(filename, ":r"),
                  ["EXTENSION"] = modify(filename, ":e"),
                  ["FILENAME"] = filename,
                  ["PATH (CWD)"] = modify(filepath, ":."),
                  ["PATH (HOME)"] = modify(filepath, ":~"),
                  ["PATH"] = filepath,
                  ["URI"] = vim.uri_from_fname(filepath),
                }

                local options = vim.tbl_filter(function(val)
                  return vals[val] ~= ""
                end, vim.tbl_keys(vals))
                if vim.tbl_isempty(options) then
                  -- utils.notify("No values to copy", vim.log.levels.WARN)
                  return
                end
                table.sort(options)
                vim.ui.select(options, {
                  prompt = "Choose to copy to clipboard:",
                  format_item = function(item)
                    return ("%s: %s"):format(item, vals[item])
                  end,
                }, function(choice)
                  local result = vals[choice]
                  if result then
                    -- utils.notify(("Copied: `%s`"):format(result))
                    vim.fn.setreg("+", result)
                  end
                end)
              end,
            },
            window = {
              position = "float",
              mappings = {
                ["<space>"] = "none",
                ["Y"] = "copy_selector",
              },
            },
            default_component_configs = {
              indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
              },
            },
          }
          require("neo-tree").setup(opts)
        end
      end,
    },
    plugins = {
      close_windows = {
        hooks = { "before_save", "before_load" },
        preserve_layout = true, -- or fun(win): boolean
        match = {
          floating = true,
          buftype = {},
          filetype = {},
          custom = false, -- or fun(win): boolean
        },
      },
      delete_hidden_buffers = false,
      -- delete_hidden_buffers = {
      --   hooks = {
      --     "before_load",
      --     vim.o.sessionoptions:match("buffer") and "before_save",
      --   },
      --   force = false, -- or fun(buf): boolean
      -- },
      nvim_tree = true,
      neo_tree = true,
      symbols_outline = true,
      outline = true,
      tabby = true,
      dap = true,
      dapui = true,
      neotest = true,
      kulala = true,
      delete_buffers = true,
      stop_lsp_clients = false,
    },
    telescope = {
      previewer = {
        enabled = true,
        previewer = "pretty", -- or 'raw' or fun(opts): Previewer
        wrap_lines = true,
        include_empty_plugin_data = false,
        cwd_colors = {
          cwd = "Comment",
          tab_cwd = { "#cc241d", "#b16286", "#d79921", "#689d6a", "#d65d0e", "#458588" },
        },
      },
      list = {
        default_action = "load",
        mappings = {
          save = { n = "<c-x>", i = "<c-x>" },
          load = { n = "<c-v>", i = "<c-v>" },
          delete = { n = "<c-t>", i = "<c-t>" },
          rename = { n = "<c-r>", i = "<c-r>" },
          -- grep = { n = "<c-g>", i = "<c-g>" },
          -- find = { n = "<c-f>", i = "<c-f>" },
        },
      },
    },
  },
  keys = {
    {
      "<Leader>ia",
      ":PossessionSave <CR>",
      { silent = true, noremap = true },
      desc = "add session",
    },
    {
      "<Leader>ie",
      ":Telescope possession list <CR>",
      { silent = true, noremap = true },
      desc = "list sessions",
    },
    {
      "<Leader>ii",
      ":PossessionLoadCwd<CR>",
      { silent = true, noremap = true },
      desc = "load cwd",
    },
  },
}
