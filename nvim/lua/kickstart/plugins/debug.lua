-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'nvim-neotest/nvim-nio',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        "codelldb",
        "cpptools",
        'js-debug-adapter',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!

    vim.keymap.set('n', '<A-1>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<A-2>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<A-3>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<A-4>', dap.step_out, { desc = 'Debug: Step Out' })

    vim.keymap.set('n', '<leader>d1', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>d2', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>d3', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>d4', dap.step_out, { desc = 'Debug: Step Out' })

    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<A-6>', dapui.toggle, { desc = 'Debug: See last session result.' })
    vim.keymap.set('n', '<leader>d6', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()


    -- Add TypeScript/JavaScript configurations
dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = { vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
  }
}

dap.configurations.javascript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    cwd = '${workspaceFolder}',
  },
  {
    type = 'pwa-node',
    request = 'attach',
    name = 'Attach',
    processId = require('dap.utils').pick_process,
    cwd = '${workspaceFolder}',
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Debug Jest Tests',
    -- trace = true, -- include debugger info
    runtimeExecutable = 'node',
    runtimeArgs = {
      './node_modules/.bin/jest',
      '--runInBand',
    },
    rootPath = '${workspaceFolder}',
    cwd = '${workspaceFolder}',
    console = 'integratedTerminal',
    internalConsoleOptions = 'neverOpen',
  }
}

dap.configurations.typescript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file',
    runtimeExecutable = 'node',
    runtimeArgs = { '--loader', 'tsx' },
    program = '${file}',
    cwd = '${workspaceFolder}',
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**"
    },
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Debug Vitest Tests',
    runtimeExecutable = 'node',
    runtimeArgs = {
      './node_modules/.bin/vitest',
      '--run'
    },
    rootPath = '${workspaceFolder}',
    cwd = '${workspaceFolder}',
    console = 'integratedTerminal',
    internalConsoleOptions = 'neverOpen',
  }
}

    -- For TSX/JSX files
    dap.configurations.typescriptreact = dap.configurations.typescript
    dap.configurations.javascriptreact = dap.configurations.javascript

    -- Install rust / codelldb specific config
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
        args = {"--port", "${port}"},
      }
    }

    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
  end,
}
