-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jk = escape
vim.keymap.set({ "i" }, "jk", "<Esc>")

-- <C-a> = select all, turns out I use this a bunch.
vim.keymap.set({ "n" }, "<D-a>", "ggVG")
vim.keymap.set({ "i", "v" }, "<D-a>", "<ESC>ggVG")

-- vscode: <C--> should jump back to the previous cursor location in addition to <C-o>, <C-t>
vim.keymap.set({ "n", "i" }, "<C-->", "<C-o>")

-- vscode: <C-.> triggers code actions
vim.keymap.set({ "n" }, "<C-.>", ",ca", { remap = true })

-- <Alt-BS> should remove a whole word.
vim.keymap.set({ "i" }, "<A-bs>", "<C-w>")

-- <D-{>, <D-}> should move between buffers
vim.keymap.set({ "n" }, "<D-{>", ":bp<CR>")
vim.keymap.set({ "n" }, "<D-}>", ":bn<CR>")

-- <D-p> opens (LazyVim) file finder
vim.keymap.set({ "n" }, "<D-p>", ",ff", { remap = true })
