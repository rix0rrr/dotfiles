-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jk = escape
vim.keymap.set({ "i" }, "jk", "<Esc>")

-- <D-a> = select all, turns out I use this a bunch.
vim.keymap.set({ "n" }, "<D-a>", "ggVG")
vim.keymap.set({ "i", "v" }, "<D-a>", "<ESC>ggVG")

-- vscode: <C--> should jump back to the previous cursor location in addition to <C-o>, <C-t>
vim.keymap.set({ "n", "i" }, "<C-->", "<C-o>")

-- vscode: <D-.> triggers code actions
vim.keymap.set({ "n" }, "<D-.>", ",ca", { remap = true })

-- <Alt-BS> should remove a whole word.
vim.keymap.set({ "i" }, "<A-bs>", "<C-w>")

-- <D-{>, <D-}> should move between buffers
vim.keymap.set({ "n" }, "<D-{>", ":bp<CR>")
vim.keymap.set({ "n" }, "<D-}>", ":bn<CR>")

-- <D-p> opens (LazyVim) file finder
vim.keymap.set({ "n" }, "<D-p>", ",ff", { remap = true })

-- <C-s> saves both in UI as well as (Kitty) terminal
vim.keymap.set({ "n", "i", "v" }, "<D-s>", function()
  vim.cmd.write()
end, { desc = "Save" })

-- <leader>go opens current file on GitHub
vim.keymap.set({ "n" }, "<leader>go", function()
  Snacks.gitbrowse()
end, { desc = "Open on GitHub" })

-- ZZ should do what I want it to do (write/close and exit), but then in LazyVim's opinionated buffers/windows system
vim.keymap.set({ "n" }, "ZZ", function()
  local function is_file_buf(buf)
    return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_get_option_value("buftype", { buf = buf }) == ""
  end

  -- Only if the current buffer is a writable file-backed buffer. Only '' are normal file buffers.
  if not is_file_buf(0) then
    return
  end

  -- Save if we have a file name
  if vim.api.nvim_buf_get_name(0) ~= "" then
    vim.cmd.write()
  end

  -- If it's the last buffer then exit, otherwise delete this buffer.
  local valid_bufs = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if is_file_buf(buf) then
      valid_bufs = valid_bufs + 1
    end
  end
  vim.print({ "valid bufs", valid_bufs })
  if valid_bufs == 1 then
    vim.cmd(":qa")
  else
    require("snacks").bufdelete()
  end
end)
