-- git stuff
if true then
  return {}
end
return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'petertriho/cmp-git', opts = {} },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = 'git' })
    end,
  },
}
