return {
  "cajames/copy-reference.nvim",
  opts = {}, -- optional configuration
  keys = {
    { "<leader>lf", "<cmd>CopyReference file<cr>", mode = { "n", "v" }, desc = "Copy file path" },
    { "<leader>lr", "<cmd>CopyReference line<cr>", mode = { "n", "v" }, desc = "Copy file:line reference" },
  },
}
