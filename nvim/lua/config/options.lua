-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","

vim.print("X")

-- Just absolute line numbers
vim.opt.relativenumber = false

-- Don't need to see invisible characters
vim.opt.list = false

-- No AI please
vim.g.ai_cmp = false

if vim.g.neovide then
  vim.opt.guifont = "MesloLGM Nerd Font"

  -- Go away with your crazy animations
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0

  local function save()
    vim.cmd.write()
  end
  local function copy()
    vim.cmd([[normal! "+y]])
  end
  local function paste()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end
  local function quit()
    -- TODO: Maybe check for tabs and close a tab instead?
    vim.cmd(":quit")
  end

  vim.keymap.set({ "n", "i", "v" }, "<D-s>", save, { desc = "Save" })
  vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy" })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste" })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-w>", quit, { desc = "Quit" })

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
