-- /home/user/.config/nvim/lua/custom/functions.lua

local M = {}

local bookmarks = require('custom.plugins.configs.bookmarks')


vim.api.nvim_create_user_command("Bookmark", function(opts)
  local number = tonumber(opts.args)
  if number then
    bookmarks.go_to_bookmark(number)
  else
    vim.notify("Invalid bookmark number", vim.log.levels.ERROR)
  end
end, { nargs = 1 })








---------------------
---------------------
---------------------
---------------------

-- NOTE : FIND AND REPLACE




-- Global Replace function
M.GlobalReplace = function()
local search = vim.fn.input 'Search for: '
  if search == '' then
    return
  end
  local replace = vim.fn.input 'Replace with: '
  local escaped_search = search:gsub('([%^%$%(%)%%%.%[%]%*%+%-%?])', '%%%1')
  vim.cmd(string.format('%%s/%s/%s/g', escaped_search, replace))
  local num_subs = vim.fn.eval "''"
  print(string.format('\nReplaced %s occurrences', num_subs))
end








M.project_search_and_replace = function()
  local search = vim.fn.input 'Search string: '
  if search == '' then
    return
  end
  local replace = vim.fn.input 'Replace with: '

  local cwd = vim.fn.getcwd()

  require('telescope.builtin').grep_string {
    search = search,
    use_regex = false,
    cwd = cwd,
  }

  local confirm = vim.fn.input 'Replace all occurrences? (y/n): '
  if confirm:lower() ~= 'y' then
    return
  end

  -- Modify the command to use global substitution
  local command = string.format("rg '%s' %s -l | xargs sed -i 's/%s/%s/g'",
    search:gsub("'", "'\\''"),
    cwd,
    search:gsub('/', '\\/'),
    replace:gsub('/', '\\/')
  )

  vim.fn.system(command)
  print 'Replacement complete.'
end





--[[



-- Project Search and Replace function
M.project_search_and_replace = function()
local search = vim.fn.input 'Search string: '
  if search == '' then
    return
  end
  local replace = vim.fn.input 'Replace with: '
  require('telescope.builtin').grep_string {
    search = search,
    use_regex = false,
  }
  local confirm = vim.fn.input 'Replace all occurrences? (y/n): '
  if confirm:lower() ~= 'y' then
    return
  end
  local command = string.format("rg '%s' -l | xargs sed -i 's/%s/%s/g'", search:gsub("'", "'\\''"), search:gsub('/', '\\/'), replace:gsub('/', '\\/'))
  vim.fn.system(command)
  print 'Replacement complete.'
end







]]--

---------------------




---------------------
---------------------




---------------------
---------------------


vim.api.nvim_create_user_command('PrettierdRestart', function()
  vim.fn.system 'pkill prettierd'
  vim.notify 'Prettierd restarted'
end, {})


---------------------
---------------------




---------------------
---------------------




---------------------
---------------------


---------------------
---------------------




-- add more functions above

return M
