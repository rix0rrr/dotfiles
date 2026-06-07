return {
  "neovide",
  dependencies = { "folke/snacks.nvim", lazy = true },
  init = function()
    Snacks.notify("Loading plugin")
    if vim.g.neovide then
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
        vim.cmd([[normal! :quit]])
      end

      vim.keymap.set({ "n", "i", "v" }, "<D-s>", save, { desc = "Save" })
      vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy" })
      vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste" })
      vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-w>", quit, { desc = "Quit" })

      -- Initial scale factor, only if the default one
      if vim.g.neovide_scale_factor == 1.0 then
        vim.g.neovide_scale_factor = 1.2
      end

      local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
      end
      vim.keymap.set("n", "<D-S-=>", function()
        change_scale_factor(1.1)
      end)
      vim.keymap.set("n", "<D-S-->", function()
        change_scale_factor(1 / 1.1)
      end)
    end
  end,
}
