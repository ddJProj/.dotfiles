-- General Key Mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local custom_functions = _G.custom_functions

-- First, unbind 't' in all relevant modes (since we're using it for movement)
vim.keymap.set('n', 't', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', 't', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('o', 't', '<Nop>', { noremap = true, silent = true })

-- Custom movement keys (h=left, t=right, j=down, k=up)
vim.keymap.set({'n', 'v', 'o'}, 'h', '<Left>', { noremap = true })
vim.keymap.set({'n', 'v', 'o'}, 't', '<Right>', { noremap = true })
vim.keymap.set({'n', 'v', 'o'}, 'j', '<Down>', { noremap = true })
vim.keymap.set({'n', 'v', 'o'}, 'k', '<Up>', { noremap = true })

-- Large movements (20 characters/lines)
vim.keymap.set('n', 'H', '20h', { noremap = true, silent = true })
vim.keymap.set('n', 'T', '20l', { noremap = true, silent = true })

-- Find character functionality (moved from 't' to 'l')
vim.keymap.set('n', 'l', function()
    local char = vim.fn.getchar()
    vim.cmd('normal! f' .. vim.fn.nr2char(char) .. 'h')
end, { noremap = true, silent = true, desc = 'Find character forward (before)' })

vim.keymap.set('n', 'L', function()
    local char = vim.fn.getchar()
    vim.cmd('normal! F' .. vim.fn.nr2char(char) .. 'l')
end, { noremap = true, silent = true, desc = 'Find character backward (after)' })

-- Search navigation
vim.keymap.set('n', '<A-y>', 'n', { noremap = true, silent = true, desc = 'Next search result' })
vim.keymap.set('n', '<A-p>', 'N', { noremap = true, silent = true, desc = 'Previous search result' })

-- Indentation
vim.keymap.set('n', '{', '<<', { noremap = true, desc = 'Indent left' })
vim.keymap.set('n', '}', '>>', { noremap = true, desc = 'Indent right' })
vim.keymap.set('v', '{', '<gv', { noremap = true, desc = 'Indent left and reselect' })
vim.keymap.set('v', '}', '>gv', { noremap = true, desc = 'Indent right and reselect' })

-- SYSTEM CLIPBOARD BINDINGS (NEW)
-- Custom yank that explicitly copies to system clipboard using + register
vim.keymap.set({'n', 'v'}, 'y', '"+y', { noremap = true, desc = 'Yank to system clipboard' })
vim.keymap.set('n', 'yy', '"+yy', { noremap = true, desc = 'Yank line to system clipboard' })

-- Keep standard delete/paste behavior (using default register)
vim.keymap.set({'n', 'v'}, 'p', 'p', { noremap = true })
vim.keymap.set({'n', 'v'}, 'P', 'P', { noremap = true })

-- Custom paste mappings from system clipboard
vim.keymap.set({'n', 'v'}, ',', '"+p', { noremap = true, desc = 'Paste from system clipboard after cursor' })
vim.keymap.set({'n', 'v'}, '<', '"+P', { noremap = true, desc = 'Paste from system clipboard before cursor' })

-- Prevent replaced text from being copied (visual mode paste)
vim.keymap.set('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = 'Dont copy replaced text' })

-- Insert new lines without moving cursor
vim.keymap.set('n', '<CR>', 'm`o<Esc>``', { noremap = true, silent = true, desc = 'Insert line below' })
vim.keymap.set('n', '<S-CR>', 'm`O<Esc>``', { noremap = true, silent = true, desc = 'Insert line above' })

-- Bookmarks
local bookmarks = require('custom.plugins.configs.bookmarks')

vim.keymap.set('n', '<leader>wba', function()
  local number = tonumber(vim.fn.input("Enter bookmark number (1-99): "))
  if number then
    local filename = vim.fn.expand("%:p")
    local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
    bookmarks.add_bookmark(number, filename, lnum, col)
  end
end, { desc = '[B]ookmark [A]dd' })

vim.keymap.set('n', '<leader>wbd', function()
  local number = tonumber(vim.fn.input("Enter bookmark number to remove: "))
  if number then
    bookmarks.remove_bookmark(number)
  end
end, { desc = '[B]ookmark [R]emove' })

-- Marks navigation
vim.keymap.set('n', '<C-b>', function()
    require('marks').next()
end, { desc = "Next mark (Ctrl+b)" })

vim.keymap.set('n', '<C-S-b>', function()
    require('marks').prev()
end, { desc = "Previous mark (Ctrl+Shift+b)" })

-- Neotree mappings
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = 'Open Neo-tree file tree' })
vim.keymap.set('n', '<leader>ut', ':Neotree focus<CR>', { noremap = true, silent = true, desc = 'Focus Neo-tree file tree' })

-- Buffer navigation
vim.keymap.set('n', '<S-Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<leader>un', '<cmd>enew<CR>', { desc = 'New buffer' })
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })
vim.keymap.set('n', '<A-X>', ':bdelete<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })

-- Toggle settings
vim.keymap.set('n', '<leader>ul', '<cmd>set nu!<CR>', { desc = 'Toggle line number' })
vim.keymap.set('n', '<leader>ur', '<cmd>set rnu!<CR>', { desc = 'Toggle relative number' })
vim.keymap.set('n', '<leader>uc', '<cmd>NvCheatsheet<CR>', { desc = 'Mapping cheatsheet' })
vim.api.nvim_set_keymap('n', '<leader>uh', '<cmd>Hardtime toggle<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>uk', function()
    vim.cmd('Screenkey toggle')
    vim.notify("Screenkey toggled", vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = 'Toggle Screenkey' })

-- Find and replace commands
vim.api.nvim_create_user_command('FR', custom_functions.GlobalReplace, {})
vim.api.nvim_create_user_command('ProjectReplace', custom_functions.project_search_and_replace, {})
vim.keymap.set('n', '<leader>crg', ':FR<CR>', { noremap = true, silent = true, desc = 'File Global - Find & Replace' })
vim.keymap.set('n', '<leader>crf', ':ProjectReplace<CR>', { noremap = true, silent = true, desc = 'Local project - Find & Replace - using RipGrep' })

-- Tmux navigation (with custom 't' for right)
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'window left' })
vim.keymap.set('n', '<C-t>', '<cmd>TmuxNavigateRight<CR>', { desc = 'window right' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'window down' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'window up' })

-- File/directory navigation
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { desc = 'cd to current file' })

-- Git/Fugitive mappings
vim.keymap.set('n', '<leader>gc', '<cmd>Git commit -a<CR>', { desc = 'Git commit -a' })
vim.keymap.set('n', '<leader>gd', '<cmd>Git diff<CR>', { desc = 'Git diff' })
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = 'Git blame' })
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gl', '<cmd>Git pull<CR>', { desc = 'Git pull' })
vim.keymap.set('n', '<leader>ga', '<cmd>Git add -A<CR>', { desc = 'Git add -A' })
vim.keymap.set('n', '<leader>gs', '<cmd>Git status<CR>', { desc = 'Git status' })

-- Terminal toggles
vim.keymap.set('t', '<A-i>', function()
  require('nvterm.terminal').toggle 'float'
end, { desc = 'Toggle floating term' })

vim.keymap.set('t', '<A-h>', function()
  require('nvterm.terminal').toggle 'horizontal'
end, { desc = 'Toggle horizontal term' })

vim.keymap.set('t', '<A-v>', function()
  require('nvterm.terminal').toggle 'vertical'
end, { desc = 'Toggle vertical term' })

vim.keymap.set('n', '<A-i>', function()
  require('nvterm.terminal').toggle 'float'
end, { desc = 'Toggle floating term' })

vim.keymap.set('n', '<A-h>', function()
  require('nvterm.terminal').toggle 'horizontal'
end, { desc = 'Toggle horizontal term' })

vim.keymap.set('n', '<A-v>', function()
  require('nvterm.terminal').toggle 'vertical'
end, { desc = 'Toggle vertical term' })

-- LSP keymaps
vim.keymap.set('n', '<leader>ciD', vim.lsp.buf.declaration, { desc = 'Go to declaration', buffer = bufnr })
vim.keymap.set('n', '<leader>cid', vim.lsp.buf.definition, { desc = 'Go to definition', buffer = bufnr })
vim.keymap.set('n', '<leader>ciK', vim.lsp.buf.hover, { desc = 'Hover information', buffer = bufnr })
vim.keymap.set('n', '<leader>cig', vim.lsp.buf.implementation, { desc = 'Go to implementation', buffer = bufnr })
vim.keymap.set('n', '<leader>Cik', vim.lsp.buf.signature_help, { desc = 'Signature help', buffer = bufnr })
