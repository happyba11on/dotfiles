local errorformat = "%E%f:%l:%c: %m"

return {
  name = "go build",
  builder = function()
    return {
      cmd = { "go", "build", "./..." },
      cwd = vim.fs.root(0, { "go.work", "go.mod" }) or vim.fn.getcwd(),
      components = {
        {
          "on_output_parse",
          errorformat = errorformat,
        },
        {
          "on_output_quickfix",
          errorformat = errorformat,
        },
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
