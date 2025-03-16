local lsp = vim.g.lazyvim_python_lsp or 'pyright'
local ruff = vim.g.lazyvim_python_ruff or 'ruff'
return {

  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local servers = { 'pyright', 'basedpyright', 'ruff', ruff, lsp }
      for _, server in ipairs(servers) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].enabled = server == lsp or server == ruff
      end
    end,
  },
}
