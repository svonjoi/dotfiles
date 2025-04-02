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

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
local function get_pkg_path(pkg, path)
  pcall(require, "mason")
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  path = path or ""
  local ret = root .. "/packages/" .. pkg .. "/" .. path
  return ret
end

return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      -- dap.set_log_level("trace")

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
      require("dap").adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }

      require("dap").adapters["chrome"] = {
        type = "chrome",
        executable = {
          command = "node",
          args = {
            get_pkg_path("chrome-debug-adapter", "/src/chromeDebug.js"),
            -- "9222",
          },
        },
      }

      local js_based_languages = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
      }
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Attach chrome
          -- google-chrome-stable --remote-debugging-port=9222 --no-first-run --no-default-browser-check --user-data-dir="/tmp/vscode-chrome-debug" --disable-extensions
          -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript-chrome
          {
            type = "chrome",
            request = "attach",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            name = "attach chrome",
            protocol = "inspector",
            sourceMaps = true,
            port = 9222,
            webRoot = "${workspaceFolder}",
          },
          -- Launch chrome
          {
            type = "pwa-chrome",
            request = "launch",
            name = "pwa-chrome ебучий хром",
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
          {
            type = "pwa-node",
            request = "launch",
            name = "node launch file",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            repl_lang = "javascript",
          },
          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          {
            type = "pwa-node",
            request = "attach",
            name = "node attach",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            repl_lang = "javascript",
          },
        }
      end
    end,
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
