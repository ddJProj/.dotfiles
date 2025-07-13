 return {
    "tpope/vim-fugitive",
    lazy = false,
    dependencies = {
      "tpope/vim-rhubarb",
      "tpope/vim-obsession",
      {
      'tpope/vim-unimpaired',
        config = function()
          -- Remove the mappings for '<' and '>'
          --vim.keymap.del('n', '<')
          --vim.keymap.del('n', '>')
          --vim.keymap.del('v', '<')
          --vim.keymap.del('v', '>')
        end,
      },
    },
  }
