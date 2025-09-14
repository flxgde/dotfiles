local M = {}

function M.switch()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local handle = io.popen("tmux list-sessions -F '#{session_name}' 2>/dev/null")
  if not handle then
    vim.notify("No tmux sessions found", vim.log.levels.WARN)
    return
  end
  local result = handle:read("*a")
  handle:close()

  local sessions = {}
  for s in string.gmatch(result, "[^\n]+") do
    table.insert(sessions, s)
  end

  if #sessions == 0 then
    vim.notify("No tmux sessions running", vim.log.levels.INFO)
    return
  end

  pickers.new({}, {
    prompt_title = "Tmux Sessions",
    finder = finders.new_table { results = sessions },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()[1]
        if vim.env.TMUX then
          vim.fn.jobstart({ "tmux", "switch-client", "-t", selection })
        else
          vim.fn.jobstart({ "tmux", "attach", "-t", selection })
        end
      end)
      return true
    end,
  }):find()
end

return M
