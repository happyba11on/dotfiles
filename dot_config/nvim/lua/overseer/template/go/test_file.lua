local errorformat = "%E%f:%l:%c: %m"

return {
  name = "go test current package",
  builder = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return {
      cmd = { "go", "test", "." },
      cwd = filename ~= "" and vim.fs.dirname(filename) or vim.fn.getcwd(),
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
