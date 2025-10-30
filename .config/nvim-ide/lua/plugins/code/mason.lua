local packages = {
  -- lsp
  "tailwindcss-language-server",
  "marksman",
  "lua-language-server",
  "html-lsp",
  "intelephense",
  "json-lsp",
  "nginx-language-server",
  "typescript-language-server",
  "vtsls",
  "vue-language-server",
  "astro-language-server",
  "bash-language-server",
  "docker-compose-language-service",
  "dockerfile-language-server",
  -- formatter
  "prettierd",
  "shfmt",
  "sqlfmt",
  "xmlformatter",
  "yamlfmt",
  "black",
  "blade-formatter",
  "jq",
  "kdlfmt",
  "markdown-toc",
  -- linter
  "phpstan",
  "shellcheck",
  -- dap
  "php-debug-adapter",
  "js-debug-adapter",
  -- combo
  "biome", -- lsp, linter, formatter
  "markdownlint-cli2", -- linter, formatter
  "stylua", -- lsp, formatter
  "taplo", -- lsp, formatter
}

local registry = require("mason-registry")

for _, pkg_name in ipairs(packages) do
  local ok, pkg = pcall(registry.get_package, pkg_name)
  if ok then
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

return {
  -- Package manager
  {
    "mason-org/mason.nvim",
  },
  -- Communication hooks between Neovim and LSPs
  {
    "neovim/nvim-lspconfig",
  },
  -- Bridge for LSPs installed using Mason
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- Whether installed servers should automatically be enabled via `:h vim.lsp.enable()`
      automatic_enable = true,
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
