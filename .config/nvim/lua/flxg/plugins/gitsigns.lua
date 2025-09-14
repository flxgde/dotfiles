return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },  -- load on buffer open
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│", hl = "GitSignsAdd" },
        change = { text = "│", hl = "GitSignsChange" },
        delete = { text = "_", hl = "GitSignsDelete" },
        topdelete = { text = "‾", hl = "GitSignsDelete" },
        changedelete = { text = "~", hl = "GitSignsChange" },
      },
      signcolumn = true,  -- show signs in the sign column
      numhl = false,      -- highlight line numbers
      linehl = false,     -- highlight whole line
      word_diff = false,  -- highlight word diffs
      current_line_blame = true, -- show blame inline
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- show at end of line
        delay = 1000,          -- ms
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Keymaps for git actions
        local map = function(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "<leader>gb", gs.blame_line, { desc = "Git blame current line" })
        map("n", "<leader>gd", gs.toggle_deleted, { desc = "Toggle deleted signs" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview git hunk" })
        map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage git hunk" })
        map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset git hunk" })
      end,
    })
  end,
}
