return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "desert",
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      -- Disable indentation guides, the colors don't work well with desert
      indent = {
        enabled = false,
      },
      -- No animation scrolling plx
      scroll = { enabled = false },
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
  },

  -- Do not have <CR> automatically insert autocomplete suggestion (annoying if it's at the
  -- end of a line, for example). Not preselecting anything so that <CR> has nothing to autocomplete,
  -- you MUST use <C-y>, <C-n>, <C-p> instead.
  {
    {
      "saghen/blink.cmp",
      optional = true,
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
}

-- TODO
-- Switching tabs
-- Ctrl-P file manager
--
-- Reminders:
