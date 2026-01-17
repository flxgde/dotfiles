return {
  "catppuccin/nvim",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      flavour = "macchiato",
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
-- return {
--   "shaunsingh/nord.nvim",
--   priority = 1000,
--   config = function()
-- 
-- 
--     vim.g.nord_disable_background = true
-- 
--     vim.cmd.colorscheme "nord"
--   end,
-- }
