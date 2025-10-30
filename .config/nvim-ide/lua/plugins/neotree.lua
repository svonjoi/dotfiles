return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>E",
      "<cmd>Neotree reveal<cr>",
      desc = "Explorer NeoTree (reveal)",
    },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Git explorer",
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Buffer explorer",
    },
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      -- :h neo-tree-filtered-items
      -- filtered_items = {
      --   visible = false, -- when true, they will just be displayed differently than normal items
      --   hide_dotfiles = true,
      --   hide_gitignored = true,
      --   hide_by_name = {
      --     ".DS_Store",
      --     "thumbs.db",
      --     --"node_modules",
      --   },
      --   hide_by_pattern = {
      --     "/home/svonjoi/*",
      --     -- "*/.config/*",
      --     --".gitignored",
      --   },
      --   always_show_by_pattern = { -- uses glob style patterns
      --     "*/.config",
      --     "*/.config/scripts",
      --     "*/.config/scripts/*",
      --     "*/.config/bat",
      --     "*/.config/bat/*",
      --     "*/.config/dunst",
      --     "*/.config/dunst/*",
      --     "*/.config/i3",
      --     "*/.config/i3/*",
      --     "*/.config/keyd",
      --     "*/.config/keyd/*",
      --     "*/.config/kitty",
      --     "*/.config/kitty/*",
      --     "*/.config/nvim-kickstart",
      --     "*/.config/nvim-kickstart/*",
      --     "*/.config/nvim-lazyvim",
      --     "*/.config/nvim-lazyvim/*",
      --     "*/.config/polybar",
      --     "*/.config/polybar/*",
      --     "*/.config/qutebrowser",
      --     "*/.config/qutebrowser/*",
      --     "*/.config/ranger",
      --     "*/.config/ranger/*",
      --     "*/.config/sxhkd",
      --     "*/.config/sxhkd/*",
      --     "*/.config/zellij",
      --     "*/.config/zellij/*",
      --     "*/.config/sioyek",
      --     "*/.config/sioyek/*",
      --     "*/.config/picom.conf",
      --     "*/.config/lazydocker/*",
      --     "*/.config/lazygit/*",
      --     ".emacs",
      --     ".zshrc",
      --     -- "README.md",
      --   },
      --   never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
      --     --".DS_Store",
      --     --"thumbs.db",
      --   },
      --   never_show_by_pattern = { -- uses glob style patterns
      --     --".null-ls_*",
      --   },
      -- },
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
  },
}
