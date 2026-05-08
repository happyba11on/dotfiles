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

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if client.config.root_dir and path:find(client.config.root_dir, 1, true) == 1 then
            return client.config.root_dir
        end
    end

    return root_from_markers(path, { '.git' })
        or root_from_markers(path, {
            'Cargo.toml',
            'go.mod',
            'go.work',
            'pyproject.toml',
            'setup.py',
            'package.json',
        })
        or vim.loop.cwd()
end

vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({ cwd = project_root() })
end, { desc = 'Telescope find files' })

vim.keymap.set('n', '<leader>fg', function()
    builtin.live_grep({ cwd = project_root() })
end, { desc = 'Telescope live grep' })

vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

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
