return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
        { '<leader>gi', '<cmd>Telescope lsp_implementations<cr>', desc = 'Telescope implementations' },
    },
    config = function()
        require('telescope').setup()
        require('telescope').load_extension('fzf')
    end,
}
