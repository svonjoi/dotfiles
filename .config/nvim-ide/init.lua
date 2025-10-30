-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("common.functions")

vim.api.nvim_create_user_command(
  "TransliterateWesternEuropeBuffer",
  "%!iconv -t ascii//TRANSLIT",
  { desc = "Transliterate Western European characters to ASCII" }
)
