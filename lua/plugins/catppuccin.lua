return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "catppuccin-mocha"
  end
}



-- vim.cmd.colorscheme "catppuccin-mocha" -- colorscheme: catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
