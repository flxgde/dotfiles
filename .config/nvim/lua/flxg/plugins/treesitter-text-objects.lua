return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local swap = require("nvim-treesitter-textobjects.swap")
    local repeatable = require("nvim-treesitter-textobjects.repeatable_move")

    -- --- select ---
    local select_maps = {
      ["a="] = { "@assignment.outer", "Outer assignment" },
      ["i="] = { "@assignment.inner", "Inner assignment" },
      ["l="] = { "@assignment.lhs", "Assignment LHS" },
      ["r="] = { "@assignment.rhs", "Assignment RHS" },

      ["a:"] = { "@property.outer", "Outer object property" },
      ["i:"] = { "@property.inner", "Inner object property" },
      ["l:"] = { "@property.lhs", "Property LHS" },
      ["r:"] = { "@property.rhs", "Property RHS" },

      ["aa"] = { "@parameter.outer", "Outer parameter" },
      ["ia"] = { "@parameter.inner", "Inner parameter" },

      ["ai"] = { "@conditional.outer", "Outer conditional" },
      ["ii"] = { "@conditional.inner", "Inner conditional" },

      ["al"] = { "@loop.outer", "Outer loop" },
      ["il"] = { "@loop.inner", "Inner loop" },

      ["af"] = { "@call.outer", "Outer function call" },
      ["if"] = { "@call.inner", "Inner function call" },

      ["am"] = { "@function.outer", "Outer function def" },
      ["im"] = { "@function.inner", "Inner function def" },

      ["ac"] = { "@class.outer", "Outer class" },
      ["ic"] = { "@class.inner", "Inner class" },
    }
    for key, spec in pairs(select_maps) do
      vim.keymap.set({ "x", "o" }, key, function()
        select.select_textobject(spec[1], "textobjects")
      end, { desc = spec[2] })
    end

    -- --- swap ---
    local swap_next_maps = {
      ["<leader>na"] = "@parameter.inner",
      ["<leader>n:"] = "@property.outer",
      ["<leader>nm"] = "@function.outer",
    }
    local swap_prev_maps = {
      ["<leader>pa"] = "@parameter.inner",
      ["<leader>p:"] = "@property.outer",
      ["<leader>pm"] = "@function.outer",
    }
    for key, q in pairs(swap_next_maps) do
      vim.keymap.set("n", key, function() swap.swap_next(q) end, { desc = "Swap next " .. q })
    end
    for key, q in pairs(swap_prev_maps) do
      vim.keymap.set("n", key, function() swap.swap_previous(q) end, { desc = "Swap prev " .. q })
    end

    -- --- move ---
    local move_maps = {
      goto_next_start = {
        ["]f"] = { "@call.outer", "textobjects" },
        ["]m"] = { "@function.outer", "textobjects" },
        ["]c"] = { "@class.outer", "textobjects" },
        ["]i"] = { "@conditional.outer", "textobjects" },
        ["]l"] = { "@loop.outer", "textobjects" },
        ["]s"] = { "@scope", "locals" },
        ["]z"] = { "@fold", "folds" },
      },
      goto_next_end = {
        ["]F"] = { "@call.outer", "textobjects" },
        ["]M"] = { "@function.outer", "textobjects" },
        ["]C"] = { "@class.outer", "textobjects" },
        ["]I"] = { "@conditional.outer", "textobjects" },
        ["]L"] = { "@loop.outer", "textobjects" },
      },
      goto_previous_start = {
        ["[f"] = { "@call.outer", "textobjects" },
        ["[m"] = { "@function.outer", "textobjects" },
        ["[c"] = { "@class.outer", "textobjects" },
        ["[i"] = { "@conditional.outer", "textobjects" },
        ["[l"] = { "@loop.outer", "textobjects" },
      },
      goto_previous_end = {
        ["[F"] = { "@call.outer", "textobjects" },
        ["[M"] = { "@function.outer", "textobjects" },
        ["[C"] = { "@class.outer", "textobjects" },
        ["[I"] = { "@conditional.outer", "textobjects" },
        ["[L"] = { "@loop.outer", "textobjects" },
      },
    }
    for fn, maps in pairs(move_maps) do
      for key, spec in pairs(maps) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          move[fn](spec[1], spec[2])
        end, { desc = fn .. " " .. spec[1] })
      end
    end

    -- --- repeatable move ---
    vim.keymap.set({ "n", "x", "o" }, ";", repeatable.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", repeatable.repeat_last_move_opposite)
    vim.keymap.set({ "n", "x", "o" }, "f", repeatable.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", repeatable.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", repeatable.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", repeatable.builtin_T_expr, { expr = true })
  end,
}
