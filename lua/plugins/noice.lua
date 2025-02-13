return {
  {
    'folke/noice.nvim',
    enabled = require('nixCatsUtils').enableForCategory 'nice-ui',
    event = 'VeryLazy',
    opts = {
      presets = { command_palette = true },
      -- add any options here
      cmdline = {
        enabled = true,
      },

      messages = { enabled = true },
      popupmenu = { enabled = true },
      lsp = {
        progress = {
          enabled = false,
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- 'rcarriga/nvim-notify',
    },
  },
}
