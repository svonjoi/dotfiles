-- TODO: https://github.com/igorlfs/nvim-dap-view

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
    dependencies = {
      -- "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>d.", function() ShowActiveDebugSessions() end, desc = "list breakpoints", },
      { "<leader>dA", "<cmd>DapNew<cr>", desc = "New session", },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      -- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "x", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapConditionalBreakpoint", { text = "󱐋*", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "󱞩", texthl = "", linehl = "", numhl = "" })

      local dap = require("dap")
      -- dap.set_log_level("trace")

      -- ADAPTERS
      local registry = require("mason-registry")
      dap.adapters.php = {
        type = "executable",
        -- https://github.com/mason-org/mason.nvim/blob/main/CHANGELOG.md#package-api-changes
        -- command = registry.get_package("php-debug-adapter"):get_install_path() .. "/php-debug-adapter",
        -- TODO: veriy
        command = vim.fn.expand("$MASON/bin/kotlin-debug-adapter"),
      }

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

      local my_fucking_stack = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
        "php",
      }

      for _, language in ipairs(my_fucking_stack) do
        dap.configurations[language] = {
          -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#php
          {
            type = "php",
            request = "launch",
            name = "XDebug",
            pathMappings = {
              ["/var/www/html"] = "${workspaceFolder}",
            },
            repl_lang = "php_only",
          },
          -- Launch chrome
          {
            type = "pwa-chrome",
            request = "launch",
            name = "pwa-chrome",
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
          -- Debug nodejs processes; make sure to add --inspect when you run the process
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
      require("dap.ext.vscode").load_launchjs("launch.json")
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    keys = {
      { "<leader>dE", "<cmd>Telescope dap list_breakpoints<cr>", desc = "list breakpoints" },
    },
  },
  {
    "miroshQa/debugmaster.nvim",
    config = function()
      local dm = require("debugmaster")
      -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
      -- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
      vim.keymap.set({ "n", "v" }, "<leader>D", dm.mode.toggle, { nowait = true })
      -- If you want to disable debug mode in addition to leader+d using the Escape key:
      -- vim.keymap.set("n", "<Esc>", dm.mode.disable)
      -- This might be unwanted if you already use Esc for ":noh"
      vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end,
  },
}
