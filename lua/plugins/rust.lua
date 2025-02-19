if require('nixCatsUtils').enableForCategory 'rust' then
  return {
    -- Extend auto completion
    {
      'Saecki/crates.nvim',
      event = { 'BufRead Cargo.toml' },
      opts = {
        completion = {
          crates = {
            enabled = true,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      },
    },

    -- Ensure Rust debugger is installed
    {
      'williamboman/mason.nvim',
      optional = true,
      enabled = require('nixCatsUtils').lazyAdd(true, false),
      opts = { ensure_installed = { 'codelldb' } },
    },

    {
      'mrcjkb/rustaceanvim',
      enabled = require('nixCatsUtils').enableForCategory 'rust',
      version = '^5', -- Recommended
      ft = { 'rust' },
      opts = {
        server = {
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr })
            vim.keymap.set('n', '<leader>cR', function()
              vim.cmd.RustLsp 'codeAction'
            end, { desc = 'Code Action', buffer = bufnr })
            vim.keymap.set('n', '<leader>dr', function()
              vim.cmd.RustLsp 'debuggables'
            end, { desc = 'Rust Debuggables', buffer = bufnr })
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust.
              checkOnSave = true,
              procMacro = {
                enable = true,
                ignored = {
                  ['async-trait'] = { 'async_trait' },
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                },
              },
            },
          },
        },
      },
      config = function(_, opts)
        vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
        -- NOTE: this came from LazyVim
        -- if vim.fn.executable 'rust-analyzer' == 0 then
        --   LazyVim.error('**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/', { title = 'rustaceanvim' })
        -- end
      end,
    },

    -- Correctly setup lspconfig for Rust 🚀
    {
      'neovim/nvim-lspconfig',
      opts = {
        servers = {
          taplo = {
            keys = {
              {
                'K',
                function()
                  if vim.fn.expand '%:t' == 'Cargo.toml' and require('crates').popup_available() then
                    require('crates').show_popup()
                  else
                    vim.lsp.buf.hover()
                  end
                end,
                desc = 'Show Crate Documentation',
              },
            },
          },
        },
      },
    },

    {
      'nvim-neotest/neotest',
      optional = true,
      opts = {
        adapters = {
          ['rustaceanvim.neotest'] = {},
        },
      },
    },
  }
end
