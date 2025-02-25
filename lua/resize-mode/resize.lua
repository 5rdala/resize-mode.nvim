local M = {}

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

return M;
