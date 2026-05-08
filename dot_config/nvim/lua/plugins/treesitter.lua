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
    local treesitter = require("nvim-treesitter")
    local parsers = require("nvim-treesitter.parsers")

    treesitter.setup()

    local installed = treesitter.get_installed()
    local missing = vim.tbl_filter(function(lang)
      return not vim.list_contains(installed, lang)
    end, languages)

    if #missing > 0 then
      if vim.fn.executable("tree-sitter") == 1 then
        treesitter.install(missing, { summary = true })
      else
        vim.schedule(function()
          vim.notify(
            "nvim-treesitter on branch 'main' needs tree-sitter-cli to install parsers",
            vim.log.levels.WARN
          )
        end)
      end
    end

    local group = vim.api.nvim_create_augroup("nvim-treesitter-main", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
          return
        end

        pcall(vim.treesitter.start, args.buf)

        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        if parsers[lang] then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
