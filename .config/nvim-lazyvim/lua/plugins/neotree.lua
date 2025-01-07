-- спиздил с внутрянки и чуть подправил
-- пришлось поеботину утиль подключать, хз нахуя. в ридми неотри нету никаких утиль
local Util = require("lazyvim.util")

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
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
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
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
          "/home/svonjoi/*",
          -- "*/.config/*",
          --".gitignored",
        },
        always_show_by_pattern = { -- uses glob style patterns
          "*/.config",
          "*/.config/scripts",
          "*/.config/scripts/*",
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
    window = {
      position = "float",
      mappings = {
        ["<space>"] = "none",
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "copy path to clipboard",
        },
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
