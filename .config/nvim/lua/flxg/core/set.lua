
local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.expandtab = true

opt.smartindent = true
opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom


vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
-- vim.g.netrw_browse_split = 4
-- vim.g.netrw_altv = 1
-- vim.g.netrw_alto = 1
-- vim.g.netrw_winsize = 25
-- vim.g.netrw_preview = 1


opt.listchars:append {
  eol = "↵",
  trail = "·",
  extends = "▶",
  precedes = "◀",
  nbsp = "⏑",
}

opt.list = true

opt.swapfile = false
opt.mouse = ""

vim.cmd [[
  highlight LineNr guifg=#888888 guibg=NONE
]]

