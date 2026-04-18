return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local parsers = {
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "prisma",
      "markdown",
      "markdown_inline",
      "svelte",
      "graphql",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
      "vimdoc",
      "c",
    }

    require("nvim-treesitter").install(parsers)

    vim.treesitter.language.register("html", "htmlangular")

    local ft_to_lang = {
      javascript = "javascript",
      javascriptreact = "javascript",
      typescript = "typescript",
      typescriptreact = "tsx",
      json = "json",
      yaml = "yaml",
      html = "html",
      htmlangular = "html",
      css = "css",
      prisma = "prisma",
      markdown = "markdown",
      svelte = "svelte",
      graphql = "graphql",
      bash = "bash",
      sh = "bash",
      zsh = "bash",
      lua = "lua",
      vim = "vim",
      dockerfile = "dockerfile",
      gitignore = "gitignore",
      query = "query",
      help = "vimdoc",
      c = "c",
    }

    local indent_disabled = { javascript = true, typescript = true, tsx = true, jsx = true }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = vim.tbl_keys(ft_to_lang),
      callback = function(ev)
        local lang = ft_to_lang[vim.bo[ev.buf].filetype]
        if not lang then return end
        pcall(vim.treesitter.start, ev.buf, lang)
        if not indent_disabled[lang] then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    require("nvim-ts-autotag").setup()
  end,
}
