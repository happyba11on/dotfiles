local snippet_cleanup_group = vim.api.nvim_create_augroup("SnippetCleanup", { clear = true })

local function stop_snippet_if_inactive_mode()
  if not (vim.snippet and vim.snippet.active()) then
    return
  end

  local mode = vim.api.nvim_get_mode().mode
  if mode:match("^[is]") then
    return
  end

  pcall(vim.snippet.stop)
end

vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave", "WinLeave" }, {
  group = snippet_cleanup_group,
  callback = function()
    vim.schedule(stop_snippet_if_inactive_mode)
  end,
})
