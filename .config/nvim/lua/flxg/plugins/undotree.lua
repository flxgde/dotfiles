return {
  "mbbill/undotree",
  lazy = false,
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
  },
  config = function()
    -- Enable persistent undo
    local undodir = vim.fn.stdpath("config") .. "/undodir"
    if vim.fn.isdirectory(undodir) == 0 then
      vim.fn.mkdir(undodir, "p")
    end
    vim.opt.undofile = true
    vim.opt.undodir = { undodir }
  end,
}
