-- NOTE: NIXCATS USERS:
-- NOTE: there are also notes added as a tutorial of how to use the nixCats lazy wrapper.
-- you can search for the following string in order to find them:
-- NOTE: nixCats:

-- like this one:
-- NOTE: nixCats: this just gives nixCats global command a default value
-- so that it doesnt throw an error if you didnt install via nix.
-- usage of both this setup and the nixCats command is optional,
-- but it is very useful for passing info from nix to lua so you will likely use it at least once.
require('nixCatsUtils').setup {
  non_nix_value = true,
}

require 'options'
require 'keymaps'
require 'autocmds'

-- NOTE: nixCats: this is where we define some arguments for the lazy wrapper.
local pluginList = nil
local nixLazyPath = nil
if require('nixCatsUtils').isNixCats then
  local allPlugins = require('nixCats').pawsible.allPlugins
  -- it is called pluginList because we only need to pass in the names
  -- this list literally just tells lazy.nvim not to download the plugins in the list.
  pluginList = require('nixCatsUtils.lazyCat').mergePluginTables(allPlugins.start, allPlugins.opt)

  -- it wasnt detecting that these were already added
  -- because the names are slightly different from the url.
  -- when that happens, add them to the list, then also specify the new name in the lazySpec
  pluginList[ [[Comment.nvim]] ] = ''
  pluginList[ [[LuaSnip]] ] = ''
  -- alternatively you can do it all in the plugins spec instead of modifying this list.
  -- just set the name and then add `dev = require('nixCatsUtils').lazyAdd(false, true)` to the spec

  -- HINT: to view the names of all plugins downloaded via nix, use the `:NixCats pawsible` command.

  -- we also want to pass in lazy.nvim's path
  -- so that the wrapper can add it to the runtime path
  -- as the normal lazy installation instructions dictate
  nixLazyPath = allPlugins.start[ [[lazy.nvim]] ]
end

-- NOTE: nixCats: You might want to move the lazy-lock.json file
local function getlockfilepath()
  if require('nixCatsUtils').isNixCats and type(require('nixCats').settings.unwrappedCfgPath) == 'string' then
    return require('nixCats').settings.unwrappedCfgPath .. '/lazy-lock.json'
  else
    return vim.fn.stdpath 'config' .. '/lazy-lock.json'
  end
end
local lazyOptions = {
  lockfile = getlockfilepath(),
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
-- NOTE: nixCats: this the lazy wrapper.
require('nixCatsUtils.lazyCat').setup(pluginList, nixLazyPath, {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  -- NOTE: nixCats: nix downloads it with a different file name.
  -- tell lazy about that.
  { 'numToStr/Comment.nvim', name = 'comment.nvim', opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = 'Code' },
        { '<leader>c_', hidden = true },
        { '<leader>d', group = 'Document' },
        { '<leader>d_', hidden = true },
        { '<leader>r', group = 'Rename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = 'Search' },
        { '<leader>s_', hidden = true },
        { '<leader>t', group = 'Toggle' },
        { '<leader>t_', hidden = true },
        { '<leader>w', group = 'Workspace' },
        { '<leader>w_', hidden = true },
        {
          mode = { 'v' },
          { '<leader>h', group = 'Git Hunk' },
          { '<leader>h_', hidden = true },
        },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- NOTE: nixCats: instead of uncommenting them, you can enable them
  -- from the categories set in your packageDefinitions in your flake or other template!
  -- This is because within them, we used nixCats to check if it should be loaded!
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'plugins' },
}, lazyOptions)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
