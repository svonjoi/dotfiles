local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

-- exclude for find_files is in .gitignore by default & .ignore - custom
-- https://github.com/nvim-telescope/telescope.nvim/issues/522
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>sG", false },
      { "<leader>sg", "<cmd>Telescope live_grep_args<cr>", desc = "Grep (with args)" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "find files" },
    },
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        -- version = "^1.0.0",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")

      return {
        extensions = {
          live_grep_args = {
            additional_args = {
              -- if a hidden file or a directory is whitelisted in an ignore file,
              -- then it will be  searched even  if  this flag isn't provided
              -- "--hidden",
              "--ignore-case",
              "--type-add=web:*.{php,blade,html,css,js}*",
              "--type-add=php:*.{php,blade}*",
              "--type-add=lua:*.{lua}*",
            },
            mappings = {
              i = {
                ["<M-y>"] = lga_actions.quote_prompt({ postfix = " -g *" }),
                ["<M-u>"] = lga_actions.quote_prompt({ postfix = " -tphp " }),
                ["<M-i>"] = lga_actions.quote_prompt({ postfix = " -tlua lazy/LazyVim/" }),
              },
            },
          },
        },
        -- <c-q> sends all results to the quickfix window
        -- actions: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua
        -- default mappings: https://github.com/nvim-telescope/telescope.nvim/blob/master/README.md#default-mappings
        defaults = {
          mappings = {
            i = {
              ["<C-a>"] = actions.results_scrolling_left,
              ["<C-e>"] = actions.results_scrolling_right,
              -- https://github.com/nvim-telescope/telescope.nvim/issues/3110#issuecomment-2395242266
              -- will be available on 2.0; UPD. Why this working?
              ["<C-f>"] = actions.preview_scrolling_left,
              ["<C-k>"] = actions.preview_scrolling_right,

              ["<C-t>"] = open_with_trouble,
              ["<C-y>"] = add_to_trouble,
            },
            n = {
              ["<C-t>"] = open_with_trouble,
              ["<C-y>"] = add_to_trouble,
            },
          },
        },
        pickers = {
          -- find_files = {
          --   theme = "dropdown",
          -- },
          buffers = {
            theme = "dropdown",
            -- не воркает
            preview = false,
            mappings = {
              i = {
                -- ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                ["<c-d>"] = actions.delete_buffer,
              },
            },
          },
        },
      }
    end,
  },
  {
    "LukasPietzschmann/telescope-tabs",
    config = function()
      require("telescope").load_extension("telescope-tabs")
      require("telescope-tabs").setup({
        -- Your custom config :^)
      })
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader><tab>e", "<cmd>Telescope telescope-tabs list_tabs<cr>", desc = "List tabs" },
    },
  },
}
