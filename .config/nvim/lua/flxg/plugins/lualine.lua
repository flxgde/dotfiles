return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    lualine.setup({
      options = {
        theme = "catppuccin",
      },
      tabline = {
        lualine_a = {'filename'},
        lualine_b = {'branch'},
        lualine_c = {'diagnostics'},
        lualine_x = {},
        lualine_y = {'lsp_status'},
        lualine_z = {'filesize'}
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'buffers' },
        lualine_c = { },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
