-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","

-- Use the dark theme
vim.o.background = "dark"

-- Just absolute line numbers
vim.opt.relativenumber = false

-- Don't need to see invisible characters
vim.opt.list = false

-- No AI please
vim.g.ai_cmp = false

-- Do not delete/yank/whatever into system clipboard; keep it separate from Vim clipboard
vim.opt.clipboard = ""

-- I trust eslint enough to fix my shit
vim.g.lazyvim_eslint_auto_format = true

if vim.g.neovide then
  vim.opt.guifont = "MesloLGM Nerd Font"

  -- Go away with your crazy animations
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0

  local function copy()
    vim.cmd([[normal! "+y]])
  end
  local function paste()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end
  local function quit()
    vim.cmd(":quit")
  end

  vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy" })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste" })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-w>", quit, { desc = "Quit" })

  -- Set initial scale factor if we start at the default of 1.0
  if vim.g.neovide_scale_factor == 1.0 then
    vim.g.neovide_scale_factor = 1.2
  end

  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<D-+>", function()
    change_scale_factor(1.1)
  end)
  vim.keymap.set("n", "<D-_>", function()
    change_scale_factor(1 / 1.1)
  end)
  vim.keymap.set("n", "<D-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end)
end

-- Do not autoformat using prettier if there is no prettier config
vim.g.lazyvim_prettier_needs_config = true
