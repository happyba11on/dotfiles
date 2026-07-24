return {
  name = "go run current file",
  builder = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return {
      cmd = {
        "go",
        "run",
        filename,
      },
      cwd = filename ~= "" and vim.fs.dirname(filename) or vim.fn.getcwd(),
      components = {
        "on_exit_set_status",
        {
          "on_complete_notify",
          statuses = { "SUCCESS", "FAILURE" },
        },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
