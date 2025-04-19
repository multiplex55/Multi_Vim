return {{
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'},
    vim.keymap.set('n', '<space>fb', ':Telescope file_browser path=%":p:h select_buffer=true<CR>', {
        desc = 'Telescope [f]ile [b]rowser'
    })
}}
