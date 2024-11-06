return {
  {
    url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'LspAttach',
    init = function()
      vim.diagnostic.config {
        -- Disable virtual_text since it's redundant due to lsp_lines.
        virtual_text = false,
        -- show only on the current line
        virtual_lines = { only_current_line = true },
      }

      require('lsp_lines').setup()
      -- TODO: add keybind to toggle
    end,
  },
}
