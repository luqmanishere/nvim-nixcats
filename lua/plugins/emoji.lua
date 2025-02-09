if true then
  return {}
end
return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-emoji' },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- TODO: figure out how to add this source
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = 'emoji' })
    end,
  },
}
