-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  -- NOTE: nixCats: return true only if category is enabled, else false
  enabled = require('nixCatsUtils').enableForCategory 'kickstart-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  -- dependencies = { 'hrsh7th/nvim-cmp' },
  config = true,
}
