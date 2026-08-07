local builtin = require('telescope.builtin')

local function root_from_markers(path, markers)
    local found = vim.fs.find(markers, {
        path = path,
        upward = true,
        stop = vim.env.HOME,
    })[1]

    return found and vim.fs.dirname(found) or nil
end

local function project_root()
    local bufname = vim.api.nvim_buf_get_name(0)
    local path = bufname ~= '' and bufname or vim.loop.cwd()

    local git_root = root_from_markers(path, { '.git' })
    if git_root then
        return git_root
    end

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if client.config.root_dir and path:find(client.config.root_dir, 1, true) == 1 then
            return client.config.root_dir
        end
    end

    return root_from_markers(path, {
        'Cargo.toml',
        'go.mod',
        'go.work',
        'pyproject.toml',
        'setup.py',
        'package.json',
    })
        or vim.loop.cwd()
end

local function todo_telescope(opts)
    local telescope = require('telescope')
    pcall(telescope.load_extension, 'todo-comments')
    telescope.extensions['todo-comments'].todo(opts)
end

vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({ cwd = project_root() })
end, { desc = 'Telescope find files' })

vim.keymap.set('n', '<leader>fg', function()
    builtin.live_grep({ cwd = project_root() })
end, { desc = 'Telescope live grep' })

vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy search current buffer' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Buffer diagnostics' })
vim.keymap.set('n', '<leader>sD', '<cmd>Telescope diagnostics<cr>', { desc = 'Workspace diagnostics' })
vim.keymap.set('n', '<leader>ss', '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>sS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', { desc = 'Workspace symbols' })
vim.keymap.set('n', '<leader>st', function()
    local filename = vim.api.nvim_buf_get_name(0)
    if filename == '' then
        vim.notify('Current buffer has no file', vim.log.levels.WARN)
        return
    end

    todo_telescope({
        cwd = vim.fs.dirname(filename),
        search_dirs = { filename },
        prompt_title = 'Find Todo in File',
    })
end, { desc = 'Todo comments in current file' })
vim.keymap.set('n', '<leader>sT', function()
    todo_telescope({
        cwd = project_root(),
        prompt_title = 'Find Todo in Project',
    })
end, { desc = 'Todo comments in project' })
vim.keymap.set('n', '<leader>gs', '<cmd>Telescope git_status<cr>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', { desc = 'Git commits' })

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end)

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end)


-- <leader> replace ctrl
-- vim.keymap.set('n', '<leader>w', '<C-w>', { desc = 'Window' })
-- vim.keymap.set('n','<leader>u','<C-u>')
-- vim.keymap.set('n','<leader>d','<C-d>')
-- vim.keymap.set('n','<leader>o','<C-o>')
-- vim.keymap.set('n','<leader>d','<C-d>')
-- vim.keymap.set('n','<leader>i','<C-i>')
