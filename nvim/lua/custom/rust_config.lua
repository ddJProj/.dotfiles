local M = {}

function M.setup()
  vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    -- LSP configuration
      autoSetHints = true,
      hover_with_actions = true,
      inlay_hints = {
        show_parameter_hints = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
      },
      },
    server = {
      on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


        client.server_capabilities.documentFormattingProvider = true
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
        -- Debug keymap
        vim.keymap.set("n", "<leader>cG", function()
          vim.cmd('RustLsp debuggables')
        end, { desc = 'Rust Debuggables', buffer = bufnr, silent = true })
        -- Run keymap
        vim.keymap.set("n", "<leader>cR", function()
          vim.cmd('RustLsp runnables')
        end, { desc = 'Rust Runnables', buffer = bufnr, silent = true })
        -- Code Action keymap
        vim.keymap.set("n", "<leader>cA", function()
          vim.cmd('RustLsp codeAction')
        end, { desc = 'Code Action', buffer = bufnr, silent = true })
        -- Rebuild Proc Macros keymap
        vim.keymap.set("n", "<leader>cP", function()
          vim.cmd('RustLsp rebuildProcMacros')
        end, { desc = 'Rebuild Proc Macros', buffer = bufnr, silent = true })
        vim.keymap.set("n", "<leader>rf", function()
          if vim.bo.filetype == "rust" then
            vim.cmd("RustFmt")
          else
            require('conform').format({ async = false, lsp_fallback = true })
          end
        end, { desc = "Format buffer (including Rust)" })




      end,
      default_settings = {
        ['rust-analyzer'] = {
          cargo =  {
            rootDirectory = vim.fn.getcwd(),
          },
          diagnostics = {
            disabled = { "unlinked-file" },
          },

          checkOnSave = {
            command = "clippy",
          },
          completion = {
            autoimport = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,

            -- Add any rust-analyzer settings here
        },
      },
    },
      -- Ensure autostart is true
      autostart = true,
    },


    -- DAP configuration
    dap = {
      adapter = require('rustaceanvim.config').get_codelldb_adapter(
        vim.fn.stdpath('data') .. '/mason/bin/codelldb',
        vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/lldb/lib/liblldb.so'
      ),
    },
  }
end

return M
