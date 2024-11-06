-- A highly configurable, and neovim style tabline plugin. Use your nvim tabs as a workspace multiplexer!

return {
  'nanozuki/tabby.nvim',
  -- event = 'VimEnter', -- if you want lazy load, see below
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    -- configs...
    require('tabby').setup()
  end,
}
