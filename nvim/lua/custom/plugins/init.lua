-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  { "nvim-neotest/nvim-nio" },
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false, -- This plugin is already lazy
    ft = { 'rust' },
  },





{
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*",
    config = function()
        -- optional: Add custom configuration here
        require("screenkey").setup({
            -- custom options here, if any
        })
         vim.cmd("Screenkey")
    end
},

  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("hardtime").setup({
        disabled_keys = { "j", "k", "h", "n" },
      })
    end,
    event = "VeryLazy",
    enabled = false,
  },

  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup()
    end,
  },



  -- {
  --     "ThePrimeagen/harpoon",
  --     branch = "harpoon2",
  --     dependencies = { "nvim-lua/plenary.nvim" },
  --     config = function()
  --       local harpoon = require("harpoon")
  --       require('better_escape').setup()
  --       harpoon:setup()
  --     end,
  -- },

  -- if issues come up with nvterm use this : https://github.com/akinsho/toggleterm.nvim?tab=readme-ov-file
  --{
  -- amongst your other plugins
  --  {'akinsho/toggleterm.nvim', version = "*", config = true}
  -- or
  --  {'akinsho/toggleterm.nvim', version = "*", opts = {--[[ things you want to change go here]]}}
  --}

  {
    'akinsho/bufferline.nvim',
    version = '*', -- Specifies you want the latest version.
    dependencies = { 'kyazdani42/nvim-web-devicons' }, -- Ensures icons are supported.
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers', -- Sets bufferline to use 'tabs' mode.
          close_command = 'bdelete! %d', -- Can be a string or function, see "Mouse actions".
          right_mouse_command = 'bdelete! %d', -- As above.
          left_mouse_command = 'buffer %d', -- As above.
          middle_mouse_command = nil, -- As above.
          -- Enabling close icons
          show_buffer_close_icons = true,
          show_close_icon = true,
          close_icon = 'x',
          --[[ close_icon = '', ]]
          separator_style = 'slant', -- or "thick" or "thin" or { 'any', 'any' }
          show_buffer_icons = true, -- disable filetype icons for buffers
          enforce_regular_tabs = true,
          always_show_bufferline = true,
          -- Unique names settings (customize as needed; this is just an example).
          -- name_formatter = function(buf) -- buf contains 'name', 'path', and 'bufnr'.
          --   -- Modify the name here if you want to change how it's displayed.
          --   return buf.name
          -- end,
          -- Adding sidebar offsets.
          offsets = {
            {
              filetype = 'neo-tree', -- Replace with the filetype of your sidebar plugin.
              text = 'File Explorer', -- Text to show in the offset section.
              highlight = 'Directory', -- Highlight group to use for the text.
              text_align = 'left', -- Alignment of the text ('left', 'center', or 'right').
              padding = 1, -- Optional padding on the left side of the offset.
            },
          },

          -- added last
          --color_icons = true, -- whether or not to add the filetype icon highlights
          --get_element_icon = function(element)
          -- element consists of {filetype: string, path: string, extension: string, directory: string}
          -- This can be used to change how bufferline fetches the icon
          -- for an element e.g. a buffer or a tab.
          --local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          -- Define your custom map before trying to return anything
          --local custom_map = {my_thing_ft = {icon = "my_thing_icon", hl = "highlight_group_name"}}
          -- Now you can return using the custom map and fallback to default icon, hl
          --return custom_map[element.filetype] or {icon, hl}
          --end,
        },
      }
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require 'custom.plugins.configs.neotree'
    end,
  },

  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },





  {
    'NvChad/nvterm',
    config = function()
      require('nvterm').setup {
        terminals = {
          shell = vim.o.shell,
          list = {},
          type_opts = {
            float = {
              relative = 'editor',
              row = 0.3,
              col = 0.25,
              width = 0.5,
              height = 0.4,
              border = 'single',
            },
            horizontal = { location = 'rightbelow', split_ratio = 0.3 },
            vertical = { location = 'rightbelow', split_ratio = 0.5 },
          },
        },
        behavior = {
          autoclose_on_quit = {
            enabled = false,
            confirm = true,
          },
          close_on_exit = true,
          auto_insert = true,
        },
      }
    end,
  },

{
  "chentoast/marks.nvim",
  config = function()
    require('marks').setup {
      -- whether to map keybinds or not. default true
      default_mappings = false,
      -- which builtin marks to show. default {}
      builtin_marks = { ".", "<", ">", "^" },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- how often (in ms) to redraw signs/recompute mark positions.
      -- higher values will have better performance but may cause visual lag,
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
      -- disables mark tracking for specific filetypes. default {}
      excluded_filetypes = {},
      -- disables mark tracking for specific buftypes. default {}
      excluded_buftypes = {},
      -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
      -- sign/virttext. Bookmarks can be used to group together positions and quickly move
      -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
      -- default virt_text is "".
      bookmark_0 = {
        sign = "⚑",
        virt_text = "merk;",
        annotate = false,
      },
      mappings = {
        set = "mx",
        set_next = "m;",
        toggle = "m-",
        delete = "dmx",
        delete_line = "dm-",
        delete_buf = "dmt",
        next = "m]",
        prev = "m[",
        preview = "m:",
        set_bookmark0 = "m0",
        set_bookmark1 = "m1",
        set_bookmark2 = "m2",
        set_bookmark3 = "m3",
        set_bookmark4 = "m4",
        set_bookmark5 = "m5",
        set_bookmark6 = "m6",
        set_bookmark7 = "m7",
        set_bookmark8 = "m8",
        set_bookmark9 = "m9",
        delete_bookmark0 = "dm0",
        delete_bookmark1 = "dm1",
        delete_bookmark2 = "dm2",
        delete_bookmark3 = "dm3",
        delete_bookmark4 = "dm4",
        delete_bookmark5 = "dm5",
        delete_bookmark6 = "dm6",
        delete_bookmark7 = "dm7",
        delete_bookmark8 = "dm8",
        delete_bookmark9 = "dm9",
        next_bookmark = "m}",
        prev_bookmark = "m{",
        delete_bookmark = "dm=",
      }
    }
  end
},













-- zz

--:marks
--H, M, L to move cursor to top, middle, bottom of screen

-- Automatically save your last position when leaving a buffer
-- vim.api.nvim_create_autocmd('BufLeave', {
--   pattern = '*',
--   callback = function()
--     vim.cmd 'normal! mZ'
--   end,
-- })

-- Check if mark exists before jumping to it
-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = '*',
--  callback = function()
--     local ok, _ = pcall(vim.cmd, 'normal! `Z')
--     if not ok then
--       -- Mark doesn't exist, do nothing
--     end
--   end,
-- })

-- Improve automatic position saving
-- vim.api.nvim_create_autocmd('BufReadPost', {
--   pattern = '*',
--   callback = function()
--     local line = vim.fn.line '\'"'
--     if line > 1 and line <= vim.fn.line '$' and vim.bo.filetype ~= 'commit' then
--       vim.cmd 'normal! g`"'
--     end
--   end,
-- })




}
