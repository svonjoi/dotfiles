return {
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      -- stylua: ignore
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    "ojroques/nvim-bufdel",
    keys = {
      -- { "<leader>bd", "<cmd>BufDel<cr>", desc = "Remove current buff" },
      -- { "<leader>bD", "<cmd>BufDel!<cr>", desc = "Remove current buff (force)" },
      { "<leader>bQ", "<cmd>BufDelOthers<cr>", desc = "Delete all buffers except the current one" },
      -- { "<leader>bR", "<cmd>BufDelOthers!<cr>", desc = "Delete all buffers except the current one (force)" },
    },
    opts = {
      next = "tabs",
      quit = false, -- quit Neovim when last buffer is closed
    },
  },
  {
    "toppair/reach.nvim",
    opts = {
      notifications = true,
    },
    keys = {
      {
        "<leader>br",
        function()
          local options = {
            handle = "dynamic", -- 'bufnr' or 'dynamic' or 'auto'
            show_icons = true,
            show_current = false, -- Include current buffer in the list
            show_modified = true, -- Show buffer modified indicator
            modified_icon = "⬤", -- Character to use as modified indicator
            grayout_current = true, -- Wheter to gray out current buffer entry
            force_delete = {}, -- List of filetypes / buftypes to use
            -- 'bdelete!' on, e.g. { 'terminal' }
            filter = nil, -- Function taking bufnr as parameter,
            -- returning true or false
            sort = nil, -- Comparator function (bufnr, bufnr) -> bool
            terminal_char = "\\", -- Character to use for terminal buffer handles
            -- when options.handle is 'dynamic'
            grayout = true, -- Gray out non matching entries

            -- A list of characters to use as handles when options.handle == 'auto'
            auto_handles = require("reach.buffers.constant").auto_handles,
            auto_exclude_handles = {}, -- A list of characters not to use as handles when
            -- options.handle == 'auto', e.g. { '8', '9', 'j', 'k' }
            previous = {
              enable = true, -- Mark last used buffers with specified chars and colors
              depth = 2, -- Maximum number of buffers to mark
              chars = { "•" }, -- Characters to use as markers,
              -- last one is used when depth > #chars
              groups = { -- Highlight groups for markers,
                "String", -- last one is used when depth > #groups
                "Comment",
              },
            },
            -- A map of action to key that should be used to invoke it
            actions = {
              split = "-",
              vertsplit = "|",
              tabsplit = "]",
              delete = "<Space>",
              priority = "=",
            },
          }

          require("reach").buffers(options)
        end,
        desc = "Reach buffers",
      },
    },
  },
}
