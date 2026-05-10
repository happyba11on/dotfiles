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

local enabled_languages = {}
for _, language in ipairs(languages) do
  enabled_languages[language] = true
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ok, treesitter = pcall(require, "nvim-treesitter")
    if not ok then
      vim.schedule(function()
        vim.notify("Failed to load nvim-treesitter", vim.log.levels.ERROR)
      end)
      return
    end

    treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local parser = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) or vim.bo[args.buf].filetype
        if enabled_languages[parser] then
          pcall(vim.treesitter.start, args.buf, parser)
        end
      end,
    })

    pcall(function()
      treesitter.install(languages)
    end)
  end,
}
