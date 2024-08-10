return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- NOTE: nixCats: return true only if category is enabled, else false
    enabled = require('nixCatsUtils').enableForCategory 'nice-ui',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = function()
      return {
        exclude = {
          filetypes = {
            'help',
            'alpha',
            'dashboard',
            'neo-tree',
            'Trouble',
            'trouble',
            'lazy',
            'mason',
            'notify',
            'toggleterm',
            'lazyterm',
          },
        },
      }
    end,
  },
}
