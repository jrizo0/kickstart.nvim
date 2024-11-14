return {
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mason-null-ls').setup {
        automatic_installation = true,
        handlers = {},
        -- Each of one of these needs to be added in the configuration for none-ls.nvim
        ensure_installed = {
          -- Diagnostics
          'hadolint',

          'prettierd',
          'stylua',

          -- Deprecated LSPs in none-ls plugin
          'eslint_d',
          'jq',
        },
      }
    end,
    lazy = true,
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'jay-babu/mason-null-ls.nvim',
      -- Adding this as a dependency because some of the default lsps were removed
      -- See https://github.com/nvimtools/none-ls.nvim/discussions/81 for more information
      'nvimtools/none-ls-extras.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    lazy = true,
    opts = function(_, opts)
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      local nls = require 'null-ls'
      local formatting = nls.builtins.formatting
      nls.setup {
        -- debug = true,
        sources = {
          -- diagnostics.actionlint,
          formatting.prettierd.with {
            extra_filetypes = { 'toml', 'solidity' },
          },
          formatting.black.with { extra_args = { '--fast' } },
        },
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                -- vim.lsp.buf.formatting_sync()
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      }
      opts.sources = vim.list_extend(opts.sources or {}, {
        -- These come from the configuration for mason-null-ls.nvim

        -- Formatter
        nls.builtins.formatting.stylua,
        -- nls.builtins.formatting.pint,

        -- Formatters based-off the new none-ls-extras plugin
        require 'none-ls.code_actions.eslint_d',
        require 'none-ls.diagnostics.eslint_d',
        require 'none-ls.formatting.eslint_d',
        require 'none-ls.formatting.jq',
      })

      -- opts.on_attach = function(current_client, bufnr)
      --   if current_client.supports_method 'textDocument/formatting' then
      --     vim.api.nvim_clear_autocmds { buffer = bufnr }
      --     vim.api.nvim_create_autocmd('BufWritePre', {
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format {
      --           filter = function(client)
      --             -- only use null-ls for formatting instead of lsp server
      --             return client.name == 'null-ls'
      --           end,
      --           bufnr = bufnr,
      --         }
      --       end,
      --     })
      --   end
      -- end
    end,
  },
}
