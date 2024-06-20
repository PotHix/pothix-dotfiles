return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  {
    "Tsuzat/NeoSolarized.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      --colorscheme = "NeoSolarized",
      colorscheme = "NeoSolarized",
    },
  },
}
