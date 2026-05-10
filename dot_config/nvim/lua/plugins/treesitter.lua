local languages = {
  "c",
  "cpp",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "python",
  "javascript",
  "typescript",
  "html",
  "css",
  "json",
  "markdown",
  "markdown_inline",
  "bash",
  "rust",
  "go",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local has_tree_sitter_cli = vim.fn.executable("tree-sitter") == 1
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = languages,
      sync_install = false,
      auto_install = has_tree_sitter_cli,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })

    if not has_tree_sitter_cli then
      vim.schedule(function()
        vim.notify(
          "nvim-treesitter on branch 'main' needs tree-sitter-cli to install missing parsers automatically",
          vim.log.levels.WARN
        )
      end)
    end
  end,
}
