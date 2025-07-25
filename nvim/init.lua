-- Congfig-nvim-KS

--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know how the Neovim basics, you can skip this step)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not sure exactly what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or neovim features used in kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your nvim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
--vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = false
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10



-- NOTE: THIS IS FILE FOR FUNCTIONS HERE :
--        .config/nvim/lua/custom/functions.lua
local custom_functions = require("custom.functions")
_G.custom_functions = custom_functions  -- globally accessible


-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
require 'custom.mappings'








-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-t>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- NOTE: "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.

  -- WHICH KEY DOES NOT REPLACE BINDS,IT ADDS TO MENU/DISPLAY

    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
      -- Document existing key chains
      require('which-key').register({
        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>d", group = "[D]ebug" },
        { "<leader>d_", hidden = true },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>w_", hidden = true },
        { "<leader>g", group = "[G]it" },
        { "<leader>g_", hidden = true },
        { "<leader>u", group = "[U]tility" },
        { "<leader>u_", hidden = true },

      })

            -- Add more specific mappings with descriptions
      require('which-key').register({
--          ["<leader>c"] = {
--            name = "[C]ode",
--          },
          ["<leader>u"] = {
            name = "[U]tility",
            l = { "<cmd>set nu!<CR>", "Toggle [l]ine number" },
            r = { "<cmd>set rnu!<CR>", "Toggle [r]elative number" },
            c = { "<cmd>NvCheatsheet<CR>", "Mapping [c]heatsheet" },
            k = { function()
              vim.cmd('Screenkey toggle')
              vim.notify("Screenkey toggled", vim.log.levels.INFO)
            end, "Toggle Screen[k]ey" },
            t = { ":Neotree focus<CR>", "Focus Neo[t]ree file tree" },
            h = { "<cmd>Hardtime toggle<CR>", "Toggle [H]ardtime" },
            n = { "<cmd>enew<CR>", "[N]ew buffer" },
          },

          ["<leader>g"] = {
            name = "[G]it",
            c = { "<cmd>Git commit -a<CR>", "[C]ommit" },
            d = { "<cmd>Git diff<CR>", "[D]iff" },
            b = { "<cmd>Git blame<CR>", "[B]lame" },
            p = { "<cmd>Git push<CR>", "[P]ush" },
            l = { "<cmd>Git pull<CR>", "Pu[l]l" },
            a = { "<cmd>Git add -A<CR>", "[A]dd all" },
            s = { "<cmd>Git status<CR>", "[S]tatus" },

          },
          ["<leader>d"] = {
            name = "[D]ebug",

          },

        ["<leader>c"] = {
          name = "[C]ode",
          a = { "<cmd>CodeActionMenu<cr>", "Code [A]ction" },
          f = { "<cmd>lua vim.lsp.buf.format()<cr>", "[F]ormat" },
          r = {
            name = "[R]eplace & Find",
            g = { ":FR<CR>", "File [G]lobal - Find & Replace" },
            f = { ":ProjectReplace<CR>", "Local project - [F]ind & Replace" },
          },
          i = {
            name = "[I]nfo",
            D = { vim.lsp.buf.declaration, "Go to [D]eclaration" },
            d = { vim.lsp.buf.definition, "Go to [d]efinition" },
            K = { vim.lsp.buf.hover, "[K] Hover information" },
            g = { vim.lsp.buf.implementation, "Go to [g]implementation" },
            h = { "<cmd>Telescope diagnostics<cr>", "Document [D]iagnostics" },
          },
          G = { function() vim.cmd('RustLsp debuggables') end, "Rust Debug[G]ables" },
          R = { function() vim.cmd('RustLsp runnables') end, "Rust [R]unnables" },
          A = { function() vim.cmd('RustLsp codeAction') end, "Rust Code [A]ction" },
          P = { function() vim.cmd('RustLsp rebuildProcMacros') end, "Rebuild [P]roc Macros" },
        },

        ["<leader>s"] = {
          name = "[S]earch",
          f = { "<cmd>Telescope find_files<cr>", "[F]ind File" },
          g = { "<cmd>Telescope live_grep<cr>", "[G]rep" },
          -- Add more search-related mappings here



        },

        ["<leader>w"] = {
          name = "[W]orkspace",
          a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "[A]dd Folder" },
          d = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "[D]elete Folder" },
          r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[R]ename buffer" },
          b = {
            name = "[B]ookmarks",
            a = { function()
              local number = tonumber(vim.fn.input("Enter bookmark number (1-99): "))
              if number then
                local filename = vim.fn.expand("%:p")
                local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
                require('custom.plugins.configs.bookmarks').add_bookmark(number, filename, lnum, col)
              end
            end, "[A]dd Bookmark" },
            d = { function()
              local number = tonumber(vim.fn.input("Enter bookmark number to remove: "))
              if number then
                require('custom.plugins.configs.bookmarks').remove_bookmark(number)
              end
            end, "[D]elete Bookmark" },
          -- Add more workspace-related mappings here
          },
        },
        ["<leader>x"] = { ":bdelete<CR>", "Close current buffer" },
      })

    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of help_tags options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'


      local bookmarks = require('custom.plugins.configs.bookmarks')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local pickers = require('telescope.pickers')
      local finders = require('telescope.finders')
      local conf = require('telescope.config').values

      vim.keymap.set('n', '<leader>sb', function()
      local bookmark_list = {}
      for number, bookmark in pairs(bookmarks.get_bookmarks()) do
        table.insert(bookmark_list, {
          number = number,
          filename = bookmark.filename,
          lnum = bookmark.lnum,
          col = bookmark.col,
        })
      end

      pickers.new({}, {
        prompt_title = "Bookmarks",
        finder = finders.new_table {
          results = bookmark_list,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.number .. ": " .. entry.filename .. ":" .. entry.lnum,
              ordinal = entry.number .. " " .. entry.filename,
              lnum = entry.lnum,
              col = entry.col,
              filename = entry.filename,
            }
          end,
        },
        sorter = conf.generic_sorter({}),
        previewer = conf.file_previewer({}),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            bookmarks.go_to_bookmark(selection.value.number)
          end)

          map('i', '<C-d>', function()
            local selection = action_state.get_selected_entry()
            if selection then
              bookmarks.remove_bookmark(selection.value.number)
              actions.close(prompt_bufnr)
              -- Reopen the picker to refresh the list
              vim.schedule(function()
                vim.cmd("lua require('telescope.builtin').find_files()")
                vim.cmd("stopinsert")
                vim.schedule(function()
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
                  vim.cmd("lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<leader>sb', true, false, true), 'n', false)")
                end)
              end)
            end
          end)

          return true
        end,
      }):find()
    end, { desc = '[S]earch [B]ookmarks' })

      --vim.keymap.set('n', '<leader>sb', function()
      --  builtin.marks({ marks = "0123456789" })
      --end, { desc = '[S]earch Global [B]ookmarks' })

      -- Search buffer marks (letters)
      vim.keymap.set('n', '<leader>sm', function()
        builtin.marks({ marks = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" })
      end, { desc = '[S]earch Buffer [M]arks' })


      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- Brief Aside: **What is LSP?**
      --
      -- LSP is an acronym you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself
          -- many times.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('df', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')


          -- Find references for the word under your cursor.
          map('dr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>dn', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          -- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          -- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.rename, { desc = '[R]e[n]ame'})
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction'})


          vim.keymap.set('n', '<leader>dd', vim.lsp.buf.hover, { desc = 'Hover Documentation'})
          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          -- map('<leader>', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          vim.keymap.set('n', '<leader>dc', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration'})

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {},
        astro = {},
        html = {},
        gopls = {},  -- Added Go
        pyright = {},  -- Added Python
        zls = {},  -- Added Zig
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        biome = {
        -- Biome will handle formatting for JS/TS files
        settings = {
          -- Biome will format on save
          formatOnSave = true,
        }},
          -- TypeScript/JavaScript support
        --tsserver = {
        --  settings = {
        --    typescript = {
        --      inlayHints = {
        --        includeInlayParameterNameHints = 'all',
        --        includeInlayVariableTypeHints = true,
        --        includeInlayPropertyDeclarationTypeHints = true,
        --        includeInlayFunctionLikeReturnTypeHints = true,
        --      }
        --    },
        --    javascript = {
        --      inlayHints = {
        --        includeInlayParameterNameHints = 'all',
        --        includeInlayVariableTypeHints = true,
        --      }
        --    }
        --  }
        --},

        -- Enhanced ESLint support
        eslint = {
          settings = {
            workingDirectory = { mode = "auto" },
            validate = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact"
            }
          }
        },

        -- Configure Emmet for React
        emmet_ls = {
          filetypes = {
            "html", "typescriptreact", "javascriptreact", "css",
            "sass", "scss", "less"
          },
          init_options = {
            jsx = {
              options = {
                ["jsx.enabled"] = true
              }
            }
          }
        },




        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },


        -- Enhance CSS support for React development
        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                compatibleVendorPrefixes = "warning",
                vendorPrefix = "warning",
                duplicateProperties = "warning",
                emptyRules = "warning"
              }
            }
          }
        },
        -- Add the new servers here
        mdx_analyzer = {},
        marksman = {},
        markdown_oxide = {
          -- Uncomment and adjust the path for your Obsidian vault if needed
          -- settings = {
          --   workspace_path = "/path/to/your/obsidian/vault"
          -- }
        },
        lemminx = {}, -- XML language server
        dockerls = {},
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
              },
            },
          },
        },
        bashls = {},
      }

      -- FIXME: filetypes

      vim.filetype.add {
        extension = {
          astro = 'astro',
          mdx = 'mdx',
          yaml = 'yaml',
          yml = 'yaml',
          dockerfile = 'dockerfile',
          sh = 'bash',
          bash = 'bash',
          tsx = 'typescriptreact',
          jsx = 'javascriptreact',
          ts = 'typescript',
          js = 'javascript',
        },
      }


      -- Enable spell checking
      vim.opt.spell = true
      vim.opt.spelllang = { 'en_us' }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
        'xmlformatter', -- XML formatter
        'css-lsp',
        'eslint',
        'emmet-ls',
        'gopls',  -- Add Go
        'pyright',  -- Add Python
        'zls',  -- Add Zig
        'dockerfile-language-server',
        'yaml-language-server',
        'bash-language-server',  -- Add Bash
        'shellcheck',  -- Add Bash linting
        'shfmt',  -- Add Bash formatting
      })


      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            -- Skip setup for rust_analyzer as it's handled by rustaceanvim
            if server_name == "rust_analyzer" then
              return
            end

            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    keys = {
    --[[  {   old binding
        -- Customize or remove this keymap to your liking
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },      --]]
      {
        '<leader>cf',
            function()
              if vim.bo.filetype == "rust" then
                vim.cmd("RustFmt")
              else
                require('conform').format { async = true, lsp_fallback = true }
              end
            end,
            mode = 'n',
            desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        vim.notify("Format on save triggered for buffer: " .. bufnr)
        if vim.bo[bufnr].filetype == "rust" then
          vim.notify("Rust file detected, running RustFmt")
          vim.cmd("RustFmt")
        else
          vim.notify("Non-Rust file, using conform")
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end
      end,
      -- FIXME: TODO: INCLUDE YOUR FORMATTERS HERE W/ LANG
      formatters_by_ft = {
        rust = { 'rustfmt' },
        lua = { 'stylua' },
        javascript = { { 'prettierd', 'prettier', 'biome' } },
        html = { 'prettierd', 'prettier' },
        cpp = { 'clang-format' },
        c = { 'clang-format' },
        astro = { 'prettierd' },
        xml = { 'xmlformatter', 'xmlformat' },
        typescript = { 'prettierd', 'biome' },
        typescriptreact = { 'prettierd', 'biome' },
        markdown = { 'prettierd' },
        mdx = { 'prettierd' },
        css = { 'prettierd' }, -- Use Prettier for CSS
        scss = { 'prettierd' }, -- Also for SCSS if you use it
        less = { 'prettierd' }, -- And for Less if you use it

        ['markdown.obsidian'] = {}, -- No formatter for Obsidian markdown
        python = { 'black' },  -- Added Python formatter
        go = { 'gofmt' },  -- Added Go formatter
        zig = { 'zigfmt' },  -- Added Zig formatter
        dockerfile = { 'hadolint' },
        yaml = { 'yamlfmt' },
        sh = { 'shfmt' },  -- Added Bash formatting
        bash = { 'shfmt' },  -- Added Bash formatting


        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      -- NOTE: added buff and lua
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-k>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-j>'] = cmp.mapping.select_prev_item(),

          -- scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          -- ['<C-l>'] = cmp.mapping(function()
          --   if luasnip.expand_or_locally_jumpable() then
          --     luasnip.expand_or_jump()
          --   end
          -- end, { 'i', 's' }),
          -- ['<C-h>'] = cmp.mapping(function()
          --   if luasnip.locally_jumpable(-1) then
          --     luasnip.jump(-1)
          --   end
          -- end, { 'i', 's' }),
          --
          --[[          -- Update the luasnip mappings (these still use Control as they're for insert mode)
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
          ]]--
          -- For more advanced luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  {
    -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    --

    -- make sure to load this before all the other start plugins
    --'folke/tokyonight.nvim',
    -- priority = 1000,
    --
    'catppuccin/nvim',
    -- name = 'catppuccin',
    priority = 1000,
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      --
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- Enable termguicolors to ensure colors are displayed correctly
      vim.opt.termguicolors = true
      -- setup must be called before loading
      vim.cmd.colorscheme 'catppuccin-mocha'

      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
     'bash',
      'c',
      'cpp',
      'rust',
      'lua',
      'javascript',
      'typescript',
      'tsx',
      'html',
      'css',
      'scss',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
      'xml',
      'astro',
      'json',
      'yaml',
      'python',  -- Add Python
      'zig',     -- Add Zig
      'go',      -- Add Go
      },




      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },


  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- put them in the right spots if you want.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
  --
  --  Here are some example plugins that I've included in the kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --

  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',

  require 'kickstart.plugins.fugitive',
  -- require 'kickstart.plugins.filetree',
  require 'kickstart.plugins.autopairs',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },


}, {
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- call the rust config file
require('custom.rust_config').setup()















-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
