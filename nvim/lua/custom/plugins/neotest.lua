return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Test adapters
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    config = function()
      local neotest = require("neotest")
      
      neotest.setup({
        adapters = {
          require("neotest-vitest")({
            -- Filter directories when searching for test files
            filter_dir = function(name, rel_path, root)
              return name ~= "node_modules"
            end,
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
        -- UI settings
        output = {
          enabled = true,
          open_on_run = true,
        },
        output_panel = {
          enabled = true,
          open = "botright split | resize 15"
        },
        quickfix = {
          enabled = true,
          open = false,
        },
        status = {
          enabled = true,
          virtual_text = true,
          signs = true,
        },
      })

      -- Keymaps for test running
      vim.keymap.set("n", "<leader>tt", function()
        neotest.run.run()
      end, { desc = "Run nearest test" })

      vim.keymap.set("n", "<leader>tf", function()
        neotest.run.run(vim.fn.expand("%"))
      end, { desc = "Run current test file" })

      vim.keymap.set("n", "<leader>td", function()
        neotest.run.run({ strategy = "dap" })
      end, { desc = "Debug nearest test" })

      vim.keymap.set("n", "<leader>ts", function()
        neotest.run.stop()
      end, { desc = "Stop test" })

      vim.keymap.set("n", "<leader>ta", function()
        neotest.run.attach()
      end, { desc = "Attach to test" })

      vim.keymap.set("n", "<leader>to", function()
        neotest.output.open({ enter = true, auto_close = true })
      end, { desc = "Show test output" })

      vim.keymap.set("n", "<leader>tO", function()
        neotest.output_panel.toggle()
      end, { desc = "Toggle test output panel" })

      vim.keymap.set("n", "<leader>tS", function()
        neotest.summary.toggle()
      end, { desc = "Toggle test summary" })

      vim.keymap.set("n", "[t", function()
        neotest.jump.prev({ status = "failed" })
      end, { desc = "Jump to previous failed test" })

      vim.keymap.set("n", "]t", function()
        neotest.jump.next({ status = "failed" })
      end, { desc = "Jump to next failed test" })
    end,
  },
}
