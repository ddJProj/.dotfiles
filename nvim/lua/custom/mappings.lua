-- General Key Mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local custom_functions = _G.custom_functions
-- First, unbind 't' in all relevant modes
vim.keymap.set('n', 't', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', 't', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('o', 't', '<Nop>', { noremap = true, silent = true })

vim.keymap.set('n', 'l', function()
    local char = vim.fn.getchar()
    vim.cmd('normal! f' .. vim.fn.nr2char(char) .. 'h')
end, { noremap = true, silent = true, desc = 'Find character forward (before)' })

vim.keymap.set('n', 'L', function()
    local char = vim.fn.getchar()
    vim.cmd('normal! F' .. vim.fn.nr2char(char) .. 'l')
end, { noremap = true, silent = true, desc = 'Find character backward (after)' })


-- Now, remap 'l' and 'L' to the desired behaviors without using 't'
--[[
vim.keymap.set('n', 'l', function()
    local char = vim.fn.getchar()
    vim.cmd('normal! f' .. vim.fn.nr2char(char))
end, { noremap = true, silent = true, desc = 'Find character forward' })

vim.keymap.set('n', 'L', function()
    local char = vim.fn.getchar()
    vim.cmd('normal! F' .. vim.fn.nr2char(char))
end, { noremap = true, silent = true, desc = 'Find character backward' })
]]--


-- debugging / code actions
--local bufnr = vim.api.nvim_get_current_buf()

--vim.keymap.set("n", "<leader>ca", function()
--  vim.cmd.RustLsp('codeAction')
--end, { desc = 'Code Action',silent = true, buffer = bufnr })

-- compile open buffer/file
--vim.keymap.set("n", "<leader>cC", function()
--  vim.cmd.RustLsp('runnable')
--end,  { desc = 'Code Compile',silent = true, buffer = bufnr })



vim.keymap.set('n', '<A-y>', 'n', { noremap = true, silent = true, desc = 'Next search result' })
vim.keymap.set('n', '<A-p>', 'N', { noremap = true, silent = true, desc = 'Previous search result' })






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

----------------------------------


----------------------------------
----------------------------------



----------------------------------
----------------------------------


-- Neotree mappings
-- Open Neo-tree file tree with Ctrl+n using the :Neotree command
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = 'Open Neo-tree file tree' })

vim.keymap.set('n', '<leader>ut', ':Neotree focus<CR>', { noremap = true, silent = true, desc = 'Focus Neo-tree file tree' })

-- Go to the next buffer with Shift+Tab
vim.keymap.set('n', '<S-Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<leader>un', '<cmd>enew<CR>', { desc = 'New buffer' })

-- Bufferline mappings
-- Close current buffer with <leader>x
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })
-- Bufferline mappings
-- Close current buffer with <leader>x
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })
-- alt + shift + x
vim.keymap.set('n', '<A-X>', ':bdelete<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })



---------------------
---------------------

vim.api.nvim_set_keymap('n', '<leader>uh', '<cmd>Hardtime toggle<CR>', {noremap = true, silent = true})

---------------------
---------------------


-- Keymaps find and replace


-- Create command for GlobalReplace
vim.api.nvim_create_user_command('FR', custom_functions.GlobalReplace, {})

-- Create command for ProjectReplace
vim.api.nvim_create_user_command('ProjectReplace', custom_functions.project_search_and_replace, {})

-- Keymaps find and replace
vim.keymap.set('n', '<leader>crg', ':FR<CR>', { noremap = true, silent = true, desc = 'File Global - Find & Replace' })
vim.keymap.set('n', '<leader>crf', ':ProjectReplace<CR>', { noremap = true, silent = true, desc = 'Local project - Find & Replace - using RipGrep' })


---------------------
---------------------

vim.keymap.set('n', '<leader>uk', function()
    vim.cmd('Screenkey toggle')
    vim.notify("Screenkey toggled", vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = 'Toggle Screenkey' })

---------------------
---------------------


-- Rebind movement keys
vim.keymap.set('', 'h', '<Left>', { noremap = true })
vim.keymap.set('', 't', '<Right>', { noremap = true })
vim.keymap.set('', 'j', '<Down>', { noremap = true })
vim.keymap.set('', 'k', '<Up>', { noremap = true })

-- Large movements (20 characters/lines)
vim.keymap.set('n', '<S-h>', '20h', { noremap = true, silent = true })
vim.keymap.set('n', '<S-t>', '20l', { noremap = true, silent = true })
--vim.keymap.set('n', '<S-k>', '20k', { noremap = true, silent = true })
--vim.keymap.set('n', '<S-j>', '20j', { noremap = true, silent = true })

--vim.keymap.set({'n', 'x', 'o'}, 't', '<Right>', { noremap = true, silent = true, priority = 1000 })



-- Normal mode
vim.keymap.set('n', '{', '<<', { noremap = true, desc = 'Indent left' })
vim.keymap.set('n', '}', '>>', { noremap = true, desc = 'Indent right' })

-- Visual mode
vim.keymap.set('v', '{', '<gv', { noremap = true, desc = 'Indent left and reselect' })
vim.keymap.set('v', '}', '>gv', { noremap = true, desc = 'Indent right and reselect' })




--[[ Normal mode: Insert new line below without moving cursor
vim.keymap.set('n', '<S-CR>', 'm`o<Esc>``', { noremap = true, silent = true, desc = 'Insert line below' })

-- Visual mode: Insert new line below selection without moving cursor
vim.keymap.set('x', '<S-CR>', '<Esc>m`o<Esc>``gv', { noremap = true, silent = true, desc = 'Insert line below selection' })

-- Insert mode: Insert new line below
vim.keymap.set('i', '<S-CR>', '<Esc>m`o', { noremap = true, silent = true, desc = 'Insert line below' })
--]]

vim.keymap.set('n', '<CR>', 'm`o<Esc>``')
vim.keymap.set('n', '<S-CR>', 'm`O<Esc>``')



-- Rebind 'till' function to 'l'
--vim.keymap.set('', 'l', 't', { noremap = true })
--vim.keymap.set('', 'L', 'T', { noremap = true })




-- New Key Mappings for Yank and Paste
-- Map 'y' to yank into register 'a'
vim.keymap.set('n', 'y', '"ay', { desc = 'Yank to register a' })
vim.keymap.set('v', 'y', '"ay', { desc = 'Yank to register a' })

-- Map ',' to paste from register 'a'
vim.keymap.set('n', ',', '"ap', { desc = 'Paste from register a' })
vim.keymap.set('v', ',', '"ap', { desc = 'Paste from register a' })


-- Map 'P' to paste from register 'a' before the cursor
vim.keymap.set('n', '<', '"aP', { desc = 'Paste from register a before the cursor' })
vim.keymap.set('v', '<', '"aP', { desc = 'Paste from register a before the cursor' })



-- Map '<' to paste from register 'a' before the cursor
--vim.keymap.set('n', 'P', '"aP', { desc = 'Paste from register a before the cursor' })
--vim.keymap.set('v', 'P', '"aP', { desc = 'Paste from register a before the cursor' })


vim.keymap.set('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = 'Dont copy replaced text' })
vim.keymap.set('n', '<leader>ul', '<cmd>set nu!<CR>', { desc = 'Toggle line number' })
vim.keymap.set('n', '<leader>ur', '<cmd>set rnu!<CR>', { desc = 'Toggle relative number' })






vim.keymap.set('n', '<leader>uc', '<cmd>NvCheatsheet<CR>', { desc = 'Mapping cheatsheet' })

-- vim.keymap.set('', 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, desc = 'Move down' })
-- vim.keymap.set('', 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, desc = 'Move up' })
-- vim.keymap.set('', '<Up>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, desc = 'Move up' })
-- vim.keymap.set('', '<Down>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, desc = 'Move down' })
-- vim.keymap.set('n', '<leader>ch', '<cmd>NvCheatsheet<CR>', { desc = 'Mapping cheatsheet' })

-- Tmux navigation (ensure Tmux and Neovim integration is correctly configured)
-- vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'window left' })
-- vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'window right' })
-- vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'window down' })
-- vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'window up' })


-- Tmux navigation (ensure Tmux and Neovim integration is correctly configured)
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'window left' })
vim.keymap.set('n', '<C-t>', '<cmd>TmuxNavigateRight<CR>', { desc = 'window right' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'window down' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'window up' })




vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { desc = 'cd to current file' })

-- Fugitive Plugin Key Mappings
vim.keymap.set('n', '<leader>gc', '<cmd>Git commit -a<CR>', { desc = 'Git commit -a' })
vim.keymap.set('n', '<leader>gd', '<cmd>Git diff<CR>', { desc = 'Git diff' })
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = 'Git blame' })
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gl', '<cmd>Git pull<CR>', { desc = 'Git pull' })
vim.keymap.set('n', '<leader>ga', '<cmd>Git add -A<CR>', { desc = 'Git add -A' })
vim.keymap.set('n', '<leader>gs', '<cmd>Git status<CR>', { desc = 'Git status' })

-- Toggle in terminal mode
vim.keymap.set('t', '<A-i>', function()
  require('nvterm.terminal').toggle 'float'
end, { desc = 'Toggle floating term' })

vim.keymap.set('t', '<A-h>', function()
  require('nvterm.terminal').toggle 'horizontal'
end, { desc = 'Toggle horizontal term' })

vim.keymap.set('t', '<A-v>', function()
  require('nvterm.terminal').toggle 'vertical'
end, { desc = 'Toggle vertical term' })

-- Toggle in normal mode
vim.keymap.set('n', '<A-i>', function()
  require('nvterm.terminal').toggle 'float'
end, { desc = 'Toggle floating term' })

vim.keymap.set('n', '<A-h>', function()
  require('nvterm.terminal').toggle 'horizontal'
end, { desc = 'Toggle horizontal term' })

vim.keymap.set('n', '<A-v>', function()
  require('nvterm.terminal').toggle 'vertical'
end, { desc = 'Toggle vertical term' })



-- Additional rust and definition keymaps
vim.keymap.set('n', '<leader>ciD', vim.lsp.buf.declaration, { desc = 'Go to declaration', buffer = bufnr })
vim.keymap.set('n', '<leader>cid', vim.lsp.buf.definition, { desc = 'Go to definition', buffer = bufnr })
vim.keymap.set('n', '<leader>ciK', vim.lsp.buf.hover, { desc = 'Hover information', buffer = bufnr })
vim.keymap.set('n', '<leader>cig', vim.lsp.buf.implementation, { desc = 'Go to implementation', buffer = bufnr })
vim.keymap.set('n', '<leader>Cik', vim.lsp.buf.signature_help, { desc = 'Signature help', buffer = bufnr })






---------------------
---------------------

-- Unmap the current binding of 'l' if necessary
--vim.keymap.del('n', 'l')

-- Remap 'l' to 'n' (since you already did this)
--vim.keymap.set('n', 'l', 'n', { noremap = true, silent = true, desc = 'Move cursor right' })


---------------------
---------------------



---------------------
---------------------





---------------------
---------------------



---------------------
---------------------



--Ctrl+P for next mark
vim.keymap.set('n', '<C-b>', function()
    require('marks').next()
end, { desc = "Next mark (Ctrl+b)" })

--Ctrl+Shift+P for previous mark
vim.keymap.set('n', '<C-S-b>', function()
    require('marks').prev()
end, { desc = "Previous mark (Ctrl+Shift+b)" })





---------------------
---------------------









