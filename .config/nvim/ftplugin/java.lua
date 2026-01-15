local jdtls = require("jdtls")
local mason_registry = require("mason-registry")

local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
local lombok_path = jdtls_path .. "/lombok.jar"

-- Find root of project
local root_markers = { "pom.xml", "build.gradle", "settings.gradle", ".git", "mvnw", "gradlew" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- Project name for workspace
local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Determine OS
local os_config = "linux"
if vim.fn.has("mac") == 1 then
  os_config = "mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "win"
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. lombok_path,
    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", jdtls_path .. "/config_" .. os_config,
    "-data", workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      inlayHints = { parameterNames = { enabled = "all" } },
      format = { enabled = true },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.junit.jupiter.api.Assertions.*",
        "org.mockito.Mockito.*",
        "org.assertj.core.api.Assertions.*",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
  },

  init_options = {
    bundles = {},
  },

  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local keymap = vim.keymap

    -- jdtls specific keymaps
    keymap.set("n", "<leader>co", jdtls.organize_imports, { buffer = bufnr, desc = "Organize imports" })
    keymap.set("n", "<leader>cv", jdtls.extract_variable, { buffer = bufnr, desc = "Extract variable" })
    keymap.set("v", "<leader>cv", function() jdtls.extract_variable(true) end, { buffer = bufnr, desc = "Extract variable" })
    keymap.set("n", "<leader>cc", jdtls.extract_constant, { buffer = bufnr, desc = "Extract constant" })
    keymap.set("v", "<leader>cc", function() jdtls.extract_constant(true) end, { buffer = bufnr, desc = "Extract constant" })
    keymap.set("v", "<leader>cm", function() jdtls.extract_method(true) end, { buffer = bufnr, desc = "Extract method" })
  end,
}

jdtls.start_or_attach(config)
