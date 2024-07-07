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

local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  -- { import = "lazyvim.plugins.extras.dap.core" },
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- спизжено со внутрянки lazyvim
      local dap = require("dap")

      local Config = require("lazyvim.config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- конфиг для пыхи
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
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Debug single nodejs files
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug web applications (client side)
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
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
            webRoot = "${workspaceFolder}",
            -- webRoot = vim.fn.getcwd(),
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
          -- Divider for the launch.json derived configs
          -- {
          --   name = "----- ↓ launch.json configs ↓ -----",
          --   type = "",
          --   request = "launch",
          -- },
        }
      end
    end,
    keys = {
      -- {
      --   "<leader>dO",
      --   function()
      --     require("dap").step_out()
      --   end,
      --   desc = "Step Out",
      -- },
      -- {
      --   "<leader>do",
      --   function()
      --     require("dap").step_over()
      --   end,
      --   desc = "Step Over",
      -- },
      -- {
      --   "<leader>da",
      --   function()
      --     if vim.fn.filereadable(".vscode/launch.json") then
      --       local dap_vscode = require("dap.ext.vscode")
      --       dap_vscode.load_launchjs(nil, {
      --         -- ["pwa-node"] = js_based_languages,
      --         -- ["node"] = js_based_languages,
      --         -- ["chrome"] = js_based_languages,
      --         ["pwa-chrome"] = js_based_languages,
      --       })
      --     end
      --     require("dap").continue()
      --   end,
      --   desc = "Run with Args",
      -- },
    },
    dependencies = {
      {
        "microsoft/vscode-js-debug",
        -- version = "1.x",
        -- After install, build it and rename the dist directory to out
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup({
            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- node_path = "node",

            -- Path to vscode-js-debug installation.
            debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

            -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
            -- debugger_cmd = { "js-debug-adapter" },

            -- which adapters to register in nvim-dap
            adapters = {
              "pwa-node",
              "pwa-chrome",
              -- "pwa-msedge",
              -- "pwa-extensionHost",
              -- "node-terminal",
              -- "chrome",
            },

            -- Path for file logging
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

            -- Logging level for output to file. Set to false to disable logging.
            -- log_file_level = false,

            -- Logging level for output to console. Set to false to disable console output.
            -- log_console_level = vim.log.levels.ERROR,
          })
        end,
      },
      {
        "Joakker/lua-json5",
        lazy = false,
        build = "./install.sh",
      },
    },
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
    },
    opts = {},
  },
}
