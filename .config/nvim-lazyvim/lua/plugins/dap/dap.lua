-- js and php dap configuration from calebdv
-- https://github.com/calebdw/dotfiles/blob/master/.config/nvim/lua/calebdw/plugins/dap.lua

vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
  require("dap").step_out()
end)

return {
  -- { import = "lazyvim.plugins.extras.dap.core" },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      -- спизжено со внутрянки lazyvim
      local dap = require("dap")
      --
      -- dap.set_log_level("trace")
      --
      -- local Config = require("lazyvim.config")
      -- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      --
      -- for name, sign in pairs(Config.icons.dap) do
      --   sign = type(sign) == "table" and sign or { sign }
      --   vim.fn.sign_define(
      --     "Dap" .. name,
      --     { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      --   )
      -- end

      -- конфиг для php
      local registry = require("mason-registry")
      dap.adapters.php = {
        type = "executable",
        command = registry.get_package("php-debug-adapter"):get_install_path() .. "/php-debug-adapter",
      }
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug in Docker",
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
          repl_lang = "php_only",
        },
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug locally",
          repl_lang = "php_only",
        },
      }

      -- конфиг для js
      local js_based_languages = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
      }
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Debug web applications (client side)
          {
            type = "pwa-chrome",
            request = "launch",
            name = "ебучий хром",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:80",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            repl_lang = "javascript",
            webRoot = "${workspaceFolder}",
            protocol = "inspector",
            sourceMaps = true,
            skipFiles = {
              "**/src/*",
              "**/node_modules/**/*",
              -- "<node_internals>/**",
              -- "${workspaceFolder}/node_modules/**/*.js",
              -- "${workspaceFolder}/js/libs/jquery-2.1.1.min.js",
              "utils.js",
              "${workspaceFolder}/.dist/*",
              "${workspaceFolder}/js/app/views/asistencia/listaArchivosView.js",
              "${workspaceFolder}/js/libs/**/*.js",
              "${workspaceFolder}/js/libs/**/**/*.js",
              "${workspaceFolder}/js/libs/jquery*.js",
              "${workspaceFolder}/js/libs/bootstrap*.js",
              "${workspaceFolder}/js/libs/backbone*.js",
              "${workspaceFolder}/js/libs/underscore*.js",
              "${workspaceFolder}/js/libs/moment.js",
              "${workspaceFolder}/js/libs/select2.min.js",
              "${workspaceFolder}/js/vendor/jquery*.js",
              "${workspaceFolder}/js/vendor/bootstrap*.js",
              "${workspaceFolder}/js/vendor/backbone*.js",
              "${workspaceFolder}/js/vendor/underscore*.js",
              "${workspaceFolder}/js/vendor/moment.js",
              "${workspaceFolder}/js/libs/**/*.js",
              "${workspaceFolder}/js/libs/require.js",
              -- "${workspaceFolder}/js/app/sanjuan.js",
              -- "${workspaceFolder}/js/app/formulario.js",
              -- "${workspaceFolder}/js/libs/*.js",
              -- "${workspaceFolder}/js/app/views/appView.js",
              -- "${workspaceFolder}/js/app/app.js",
            },
          },
          -- Debug single nodejs files
          -- {
          --   type = "pwa-node",
          --   request = "launch",
          --   name = "Launch file",
          --   program = "${file}",
          --   cwd = vim.fn.getcwd(),
          --   sourceMaps = true,
          --   repl_lang = "javascript",
          -- },
          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          -- {
          --   type = "pwa-node",
          --   request = "attach",
          --   name = "Attach",
          --   processId = require("dap.utils").pick_process,
          --   cwd = vim.fn.getcwd(),
          --   sourceMaps = true,
          --   repl_lang = "javascript",
          -- },
          -- Divider for the launch.json derived configs
          -- {
          --   name = "----- ↓ launch.json configs ↓ -----",
          --   type = "",
          --   request = "launch",
          -- },
        }
      end
    end,
    dependencies = {
      -- INFO: вроде через масон устанавливается
      {
        "microsoft/vscode-js-debug",
        -- version = "1.x",
        -- After install, build it and rename the dist directory to out
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      },

      -- {
      --   "mxsdev/nvim-dap-vscode-js",
      --   config = function()
      --     ---@diagnostic disable-next-line: missing-fields
      --     require("dap-vscode-js").setup({
      --       -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      --       -- node_path = "node",
      --
      --       -- Path to vscode-js-debug installation.
      --       debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
      --
      --       -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
      --       -- debugger_cmd = { "js-debug-adapter" },
      --
      --       -- which adapters to register in nvim-dap
      --       adapters = {
      --         "pwa-node",
      --         "pwa-chrome",
      --         -- "pwa-msedge",
      --         -- "pwa-extensionHost",
      --         -- "node-terminal",
      --         "chrome",
      --       },
      --
      --       -- Path for file logging
      --       log_file_path = "(stdpath cache)/dap_vscode_js.log",
      --
      --       -- Logging level for output to file. Set to false to disable logging.
      --       -- log_file_level = true,
      --
      --       -- Logging level for output to console. Set to false to disable console output.
      --       log_console_level = vim.log.levels.DEBUG,
      --     })
      --   end,
      -- },
      -- {
      --   "Joakker/lua-json5",
      --   lazy = false,
      --   build = "./install.sh",
      -- },
    },
  },
  -- nvim-dap adapter for vscode-js-debug
  {
    "mxsdev/nvim-dap-vscode-js",
    opts = {
      -- ~/.local/share/nvim-lazyvim/mason/packages/js-debug-adapter/
      -- debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      -- debugger_path = vim.fn.resolve(
      --   vim.fn.stdpath("data") .. "/mason/js-debug-adapter/js-debug/src/dapDebugServer.js"
      -- ),

      -- dap.adapters["pwa-chrome"] = {
      --   type = "server",
      --   host = "localhost",
      --   port = "${port}",
      --   executable = {
      --     command = "node",
      --     args = {
      --       vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      --       "${port}",
      --     },
      --   },
      -- }

      -- ~/.local/share/nvim-lazyvim/lazy/vscode-js-debug
      debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    },
    dependencies = { "mfussenegger/nvim-dap" },
  },
  -- fancy UI for the debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      { "<leader>dF", function() require("dapui").float_element(nil, {position= "center"}) end, desc = "toggle float", mode = {"n", "v"} },
      { "<leader>dR", function() require("dapui").float_element("repl", {position= "center"}) end, desc = "floating-repl", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        -- dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
  -- {
  --   "rcarriga/cmp-dap",
  -- }
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   dependencies = {
  --     "LiadOz/nvim-dap-repl-highlights",
  --   },
  --   opts = {
  --     highlight = {
  --       enable = true,
  --     },
  --     -- TODO:dap_repl does not exist as adapter
  --     -- :TSInstall dap_repl
  --
  --     ensure_installed = { "dap_repl", ... },
  --   },
  -- },
}
