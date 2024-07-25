return {
  "sunjon/shade.nvim",
  -- Conflicts with vim-maximizer and many other plugins
  -- эта хуйня ошибки окна какие то плюет
  enabled = false,
  opts = {
    overlay_opacity = 50,
    opacity_step = 1,
    keys = {
      brightness_up = "<a-up>",
      brightness_down = "<a-down>",
      toggle = "<leader><F8>",
    },
  },
}
