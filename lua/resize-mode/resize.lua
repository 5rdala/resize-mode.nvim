-- helper func to check if the current split have a window on its left
function has_split_left()
  -- get the current split
  local current_split = vim.api.nvim_get_current_win()

  -- get the split position
  local split_position = vim.api.nvim_win_get_position(current_split)

  -- if current_split column > 1
  -- it has a split on its left
  return split_position[2] > 1
end

-- helper func to check if the current split have a window on its right
function has_split_right()
  -- get the current split
  local current_split = vim.api.nvim_get_current_win()

  -- get the split position
  local split_position = vim.api.nvim_win_get_position(current_split)

  -- get the total columns
  local total_columns = vim.api.nvim_get_option("columns")

  -- if not last column it has a split on its right
  return split_position[2] < total_columns
end

-- helper func to check if the current split has a window above
function has_split_above()
  -- get the current split
  local current_split = vim.api.nvim_get_current_win()

  -- get the split position (row, column)
  local split_position = vim.api.nvim_win_get_position(current_split)

  -- if the current split is not in the first row, there is a split above
  return split_position[1] > 1
end

-- helper func to check if the current split has a window below
function has_split_below()
  -- get the current split
  local current_split = vim.api.nvim_get_current_win()

  -- get the split position (row, column)
  local split_position = vim.api.nvim_win_get_position(current_split)

  -- get the total number of rows in the window
  local total_rows = vim.api.nvim_get_option("lines")

  -- if not in the last row, there is a split below
  return split_position[1] < total_rows
end

local M = {}

function M.resize_left()
  if not has_split_left() then
    vim.cmd("vertical resize -1")
  else
    if has_split_right() then
      vim.cmd("wincmd h")
      vim.cmd("vertical resize -1")
      vim.cmd("wincmd l")
    else
      vim.cmd("vertical resize +1")
    end
  end
end

function M.resize_right()
  if not has_split_right() then
    vim.cmd("vertical resize -1")
  else
    if has_split_left() then
      vim.cmd("wincmd h")
      vim.cmd("vertical resize +1")
      vim.cmd("wincmd l")
    else
      vim.cmd("vertical resize +1")
    end
  end
end

function M.resize_up()
  if not has_split_above() then
    vim.cmd("resize -1")
  else
    if has_split_below() then
      vim.cmd("wincmd k")
      vim.cmd("resize -1")
      vim.cmd("wincmd j")
    else
      vim.cmd("resize +1")
    end
  end
end

function M.resize_down()
  if not has_split_below() then
    vim.cmd("resize +1")
  else
    if has_split_above() then
      vim.cmd("wincmd k")
      vim.cmd("resize +1")
      vim.cmd("wincmd j")
    else
      vim.cmd("resize +1")
    end
  end
end

return M;
