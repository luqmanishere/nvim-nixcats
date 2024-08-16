return {
  {
    'okuuva/auto-save.nvim',
    cmd = 'ASToggle', -- optional for lazy loading on command
    event = { 'InsertLeave', 'TextChanged' }, -- optional for lazy loading on trigger events
    opts = {
      execution_message = { enabled = false },
      -- your config goes here
      -- or just leave it empty :)
      trigger_events = { -- See :h events
        immediate_save = { 'BufLeave', 'FocusLost' }, -- vim events that trigger an immediate save
        defer_save = { 'InsertLeave', 'TextChanged' }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_defered_save = { 'InsertEnter' }, -- vim events that cancel a pending deferred save
      },
      debounce_delay = 5000, -- delay a pending save
    },
  },
}
