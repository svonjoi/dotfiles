-- require("mason").setup()
--
-- require("mason-lspconfig").setup({
--   ensure_installed = { "intelephense", "phpactor" },
-- })
--
-- -- эта ебла не работает
-- local lspconfig = require("lspconfig")
-- lspconfig.intelephense.setup({
--   settings = {
--     ["intelephense"] = {
--       compatibility = {
--         correctForArrayAccessArrayAndTraversableArrayUnionTypes = false,
--       },
--       -- → intelephense.diagnostics.embeddedLanguages                                          default: true
--       -- → intelephense.diagnostics.enable                                                     default: true
--       -- → intelephense.diagnostics.implementationErrors                                       default: true
--     },
--   },
-- })