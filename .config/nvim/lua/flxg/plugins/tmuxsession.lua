-- ~/.config/nvim/lua/flxg/localplugins/tmuxsession.lua.
return {
  {
    dir = "~/.config/nvim/lua/flxg/localplugins/tmuxsession",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
        { "<leader>h", function() require("flxg.localplugins.tmuxsession").switch() end, desc = "Switch Tmux Session" },

    },
    config = function()
      local tmux = require("flxg.localplugins.tmuxsession")
      vim.api.nvim_create_user_command("TmuxSessions", tmux.switch, {})
    end,
  },
}

