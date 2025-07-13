-- bookmarks.lua
local M = {}

local bookmark_file = vim.fn.stdpath("data") .. "/bookmarks.json"

local function read_bookmarks()
  if vim.fn.filereadable(bookmark_file) == 1 then
    local json = vim.fn.readfile(bookmark_file)[1]
    return vim.fn.json_decode(json) or {}
  end
  return {}
end

local function write_bookmarks(bookmarks)
  local json = vim.fn.json_encode(bookmarks)
  vim.fn.writefile({json}, bookmark_file)
end

M.add_bookmark = function(number, filename, lnum, col)
  if number < 1 or number > 99 then
    vim.notify("Bookmark number must be between 1 and 99", vim.log.levels.ERROR)
    return
  end
  local bookmarks = read_bookmarks()
  bookmarks[tostring(number)] = {filename = filename, lnum = lnum, col = col}
  write_bookmarks(bookmarks)
  vim.notify("Bookmark " .. number .. " added", vim.log.levels.INFO)
end

M.remove_bookmark = function(number)
  local bookmarks = read_bookmarks()
  if bookmarks[tostring(number)] then
    bookmarks[tostring(number)] = nil
    write_bookmarks(bookmarks)
    vim.notify("Bookmark " .. number .. " removed", vim.log.levels.INFO)
  else
    vim.notify("Bookmark " .. number .. " not found", vim.log.levels.WARN)
  end
end

M.get_bookmarks = function()
  return read_bookmarks()
end

M.go_to_bookmark = function(number)
  local bookmarks = read_bookmarks()
  local bookmark = bookmarks[tostring(number)]
  if bookmark then
    -- Check if the current buffer has unsaved changes
    if vim.bo.modified then
      local choice = vim.fn.input("Current buffer has unsaved changes. [S]ave, [I]gnore, [C]ancel: ")
      if choice:lower() == 's' then
        vim.cmd('write')
      elseif choice:lower() == 'i' then
        -- Continue without saving
      else
        vim.notify("Bookmark jump cancelled", vim.log.levels.INFO)
        return
      end
    end

    -- Use pcall to catch any errors when trying to edit the file
    local ok, err = pcall(function()
      vim.cmd('edit ' .. vim.fn.fnameescape(bookmark.filename))
    end)

    if not ok then
      vim.notify("Error opening file: " .. err, vim.log.levels.ERROR)
      return
    end

    -- Set cursor position
    vim.api.nvim_win_set_cursor(0, {bookmark.lnum, bookmark.col})
    vim.notify("Jumped to bookmark " .. number, vim.log.levels.INFO)
  else
    vim.notify("Bookmark " .. number .. " not found", vim.log.levels.WARN)
  end
end

return M
