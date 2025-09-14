vim.angular = { }

function vim.angular.jump()
  local filepath = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  local basename = filepath:sub(1, #filepath - #ext - 1)

  if ext == "html" then
    vim.cmd("edit " .. basename .. ".ts")
  elseif ext == "ts" then
    local html_file = basename .. ".html"
    if vim.fn.filereadable(html_file) == 1 then
      vim.cmd("edit " .. html_file)
    else
      print("No corresponding HTML file found")
    end
  else
    print("Not an Angular component file")
  end
end
