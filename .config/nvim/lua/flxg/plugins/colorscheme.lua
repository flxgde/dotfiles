return {
  "catppuccin/nvim",
  priority = 1000,
  config = function()
    local time = os.date("*t")
    if time.hour < 8 or time.hour > 19 then
      Transparent = true
    else
      Transparent = true
    end
    require("catppuccin").setup({
      transparent_background = Transparent
    })

    -- Set color scheme
    if time.hour < 8 or time.hour > 19 then
      vim.cmd.colorscheme "catppuccin-frappe"
    else
      vim.cmd.colorscheme "catppuccin-latte"
    end

    vim.cmd.colorscheme "catppuccin-frappe"
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
