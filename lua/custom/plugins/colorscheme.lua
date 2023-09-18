return {
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {},
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = true,
      })
      -- vim.cmd('colorscheme tokyonight')
    end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
      function ColorMyPencils(color)
        color = color or "rose-pine"
        vim.cmd.colorscheme(color)

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end

      -- ColorMyPencils()
    end
  },
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   priority = 1000,
  --   name = "catppuccin",
  --   opts = {
  --     flavour = "macchiato", -- latte, frappe, macchiato, mocha
  --     background = {
  --       light = "latte",
  --       dark = "mocha",
  --     },
  --     -- transparent_background = true,
  --   },
  --   config = function()
  --     vim.cmd([[colorscheme catppuccin]])
  --   end,
  -- },
  -- {
  --   'sainnhe/gruvbox-material',
  --   config = function()
  --     vim.g.gruvbox_material_foreground = 'grey'
  --     vim.g.gruvbox_material_better_performance = 1
  --     vim.g.gruvbox_material_enable_bold = 1
  --     vim.g.gruvbox_material_enable_italic = 0
  --     vim.g.gruvbox_material_transparent_background = 0
  --     vim.g.gruvbox_material_visual = 'grey background'
  --     vim.g.gruvbox_material_background = 'soft'
  --     vim.g.gruvbox_material_current_word = 'grey background'
  --     vim.g.gruvbox_material_menu_selection_background = 'aqua'
  --     vim.g.gruvbox_material_ui_contrast = 'high'
  --     vim.g.gruvbox_material_diagnostic_text_highlight = 0
  --     vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
  --     vim.g.gruvbox_material_diagnostic_line_highlight = 0 -- not working
  --   end
  -- },
  {
    'folke/lsp-colors.nvim',
    opts =
    {
      Error = "#db4b4b",
      Warning = "#e0af68",
      Information = "#0db9d7",
      Hint = "#10B981"
    }
  },
  -- { 'projekt0n/github-nvim-theme', version = 'v0.0.7' },
  -- 'lunarvim/darkplus.nvim',
}
