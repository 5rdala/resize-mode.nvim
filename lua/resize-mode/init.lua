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
end

-- func to set resize mode keybinds 
function set_keybinds()
  local opts = { noremap = true, silent = true, buffer = true }

  vim.keymap.set("n", "h", resize.resize_left, opts)

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
