local jdtls = require("jdtls")

local home = os.getenv("HOME")
local workspace_folder = home .. "/.cache/jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
  cmd = {
    "jdtls",
    "-configuration", home .. "/.cache/jdtls/config",
    "-data", workspace_folder,
  },
  root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

jdtls.start_or_attach(config)
