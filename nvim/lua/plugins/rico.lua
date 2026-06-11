return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oasis-desert",
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      -- Disable indentation guides, the colors don't work well with desert
      indent = {
        enabled = false,
      },
      -- No scrolling animation plx
      scroll = { enabled = false },

      sources = {
        explorer = {
          -- Do not show files that are gitignored in the side picker
          -- git_untracked = false,
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        -- Disable the clock at the bottom right, I already have that eh
        lualine_z = {},
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      -- Don't rebind s and S please
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "x", "o" }, false },
      -- Use Tab and Shift-Tab instead
      {
        "<Tab>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<S-Tab>",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      -- {
      --   "r",
      --   mode = "o",
      --   function()
      --     require("flash").remote()
      --   end,
      --   desc = "Remote Flash",
      -- },
      -- {
      --   "R",
      --   mode = { "o", "x" },
      --   function()
      --     require("flash").treesitter_search()
      --   end,
      --   desc = "Treesitter Search",
      -- },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- Strip trailing whitespace
  {
    "thirtythreeforty/lessspace.vim",
  },

  -- Add a scroll bar that shows annotations
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "kevinhwang91/nvim-hlslens",
    },
    opts = {
      handlers = {
        gitsigns = true,
        search = true,
      },
    },
  },

  -- Do not have <CR> automatically insert autocomplete suggestion (annoying if it's at the
  -- end of a line, for example). Not preselecting anything so that <CR> has nothing to autocomplete,
  -- you MUST use <C-y>, <C-n>, <C-p> instead. Use <Tab> instead as an alternative.
  {
    {
      "saghen/blink.cmp",
      optional = true,
      keymap = {
        preset = "super-tab",
      },
      opts = {
        completion = {
          list = {
            selection = {
              preselect = false,
            },
          },
        },
      },
    },
  },

  {
    "uhs-robert/oasis.nvim",
    -- Not exactly sure how all of this interacts with LazyVim, disabling it seems to work well enough
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   require("oasis").setup() -- (see Configuration below for all customization options)
    --   vim.cmd.colorscheme("oasis") -- After setup, apply theme (or any style like "oasis-night")
    -- end,
  },

  -- Stop inserting closing brackets, you suck at it
  { "nvim-mini/mini.pairs", enabled = false },
  { "altermo/ultimate-autopair.nvim", enabled = false },
}

-- Reminders:
--  Need to install `fd` for the file pickers to work.
--
--
-- #!/bin/bash
-- exec open -a Neovide --args --chdir=$PWD "$@" &
