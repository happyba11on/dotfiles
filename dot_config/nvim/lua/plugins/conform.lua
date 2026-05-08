return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt" },
    },
  },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "格式化",
    },
  },
}
