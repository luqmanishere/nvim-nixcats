-- A highly configurable, and neovim style tabline plugin. Use your nvim tabs as a workspace multiplexer!

return {
  'nanozuki/tabby.nvim',
  -- event = 'VimEnter', -- if you want lazy load, see below
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    -- configs...
    -- TODO: customize
    require('tabby').setup {
      preset = 'active_wins_at_tail',
      option = {
        nerdfont = true, -- whether use nerdfont
      },
    }
    vim.api.nvim_set_keymap('n', '<leader>ta', ':$tabnew<CR>', { noremap = true, desc = 'Open a new tab' })
    vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, desc = 'Close the current tab' })
    vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', { noremap = true, desc = 'Close all tabs except the current one' })
    vim.api.nvim_set_keymap('n', '<leader>tn', ':tabn<CR>', { noremap = true, desc = 'Switch to next tab' })
    vim.api.nvim_set_keymap('n', '<leader>tp', ':tabp<CR>', { noremap = true, desc = 'Switch to previous tab' })
    -- move current tab to previous position
    vim.api.nvim_set_keymap('n', '<leader>tmp', ':-tabmove<CR>', { noremap = true, desc = 'Move current tab to previous position' })
    -- move current tab to next position
    vim.api.nvim_set_keymap('n', '<leader>tmn', ':+tabmove<CR>', { noremap = true, desc = 'Move current tab to next position' })
  end,
}
