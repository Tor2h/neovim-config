return {
  -- the colorscheme should be available when starting Neovim
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        -- add the config here
        themes = {
          {
            name = "Kanagawa",
            colorscheme = "kanagawa",
          },
          {
            name = "Vague",
            colorscheme = "vague",
          },
        },
        vim.keymap.set("n", "<leader>tt", function()
          local themery = require("themery")
          local currentTheme = themery.getCurrentTheme()
          if currentTheme and currentTheme.name == "Kanagawa" then
            themery.setThemeByName("Vague", true)
          else
            themery.setThemeByName("Kanagawa", true)
          end
        end, { noremap = true }),
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,  -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
      -- load the colorscheme here

      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {         -- add/modify theme and palette colors
          palette = {},
          theme = {
            all = {
              ui = {
                bg = "none",
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },
  "rktjmp/lush.nvim",
  "tckmn/hotdog.vim",
  "dundargoc/fakedonalds.nvim",
  "craftzdog/solarized-osaka.nvim",
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        variant = "main",
        styles = {
          italic = false,
        },
        palette = {
          main = {
            base = "#000000",
          },
        },
      })
    end,
  },
  "eldritch-theme/eldritch.nvim",
  "jesseleite/nvim-noirbuddy",
  "miikanissi/modus-themes.nvim",
  "gremble0/yellowbeans.nvim",
  "rockyzhang24/arctic.nvim",
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        on_colors = function(colors)
          colors.bg = "#000000"
        end,
      })
    end,
  },
  "Shatur/neovim-ayu",
  "RRethy/base16-nvim",
  "xero/miasma.nvim",
  "cocopon/iceberg.vim",
  "kepano/flexoki-neovim",
  "ntk148v/komau.vim",
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          all = {
            base = "#000000",
          },
        },
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        palette_overrides = {
          dark0 = "#000000",
        },
      })
    end,
  },
  -- Lazy
  {
    "vague2k/vague.nvim",
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
        colors = {
          bg = "#000000",
        },
      })
    end,
  },
  {
    "ilof2/posterpole.nvim",
    priority = 1000,
    config = function()
      local posterpole = require("posterpole")
      posterpole.setup({
        colors = {
          brightness = 10,
          posterpole = {
            bgColor = "#000000",
          },
        },
        -- config here
      })

      -- This function create sheduled task, which will reload theme every hour
      -- Without "setup_adaptive" adaptive brightness will be set only after every restart
      posterpole.setup_adaptive()
    end,
  },
  "uloco/bluloco.nvim",
  "LuRsT/austere.vim",
  "ricardoraposo/gruvbox-minor.nvim",
  "NTBBloodbath/sweetie.nvim",
  "vim-scripts/MountainDew.vim",
  {
    "maxmx03/fluoromachine.nvim",
    -- config = function()
    --   local fm = require "fluoromachine"
    --   fm.setup { glow = true, theme = "fluoromachine" }
    -- end,
  },
}
