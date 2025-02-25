local resize = require("resize-mode.resize")

local M = {}

-- func check if there are splits in the current tab
local function has_splits()
  -- get the number of windows in the current tab
  return vim.fn.winnr('$') > 1
end

-- func to clear keybinds of resize mode
function clear_keybinds()
  vim.api.nvim_buf_del_keymap(0, "n", "<Esc>")
  vim.api.nvim_buf_del_keymap(0, "n", "h")
  vim.api.nvim_buf_del_keymap(0, "n", "j")
  vim.api.nvim_buf_del_keymap(0, "n", "k")
  vim.api.nvim_buf_del_keymap(0, "n", "l")

  vim.api.nvim_buf_del_keymap(0, "n", "<Left>")
  vim.api.nvim_buf_del_keymap(0, "n", "<Down>")
  vim.api.nvim_buf_del_keymap(0, "n", "<Up>")
  vim.api.nvim_buf_del_keymap(0, "n", "<Right>")
end

-- func to set resize mode keybinds 
function set_keybinds()
  local opts = { noremap = true, silent = true, buffer = true }

  -- resize using h/j/k/l
  vim.keymap.set("n", "h", resize.resize_left, opts)
  vim.keymap.set("n", "j", resize.resize_down, opts)
  vim.keymap.set("n", "k", resize.resize_up, opts)
  vim.keymap.set("n", "l", resize.resize_right, opts)

  -- resize using arrow keys
  vim.keymap.set("n", "<Left>", resize.resize_left, opts)
  vim.keymap.set("n", "<Down>", resize.resize_down, opts)
  vim.keymap.set("n", "<Up>", resize.resize_up, opts)
  vim.keymap.set("n", "<Right>", resize.resize_right, opts)

  -- exit resize mode with Esc
  vim.keymap.set("n", "<Esc>", function()
    clear_keybinds()
    vim.cmd("echo ''")
  end, opts)
end

function M.resize_mode()
  -- check if the current windows has no splits
  if not has_splits() then
    vim.api.nvim_err_writeln("[Resize Mode] Err: No splits in the current tab!")
    return
  end

  -- print resize mode indicator
  vim.cmd("echo '-- RESIZE MODE --'")

  -- set resize mode keybinds
  set_keybinds()
end

return M;
