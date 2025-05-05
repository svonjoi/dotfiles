return {
  -- this play bad with midnight theme; instead enabled indent-blankline.nvim from extras
  -- https://www.lazyvim.org/extras/ui/indent-blankline#snacksnvim
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },
}
