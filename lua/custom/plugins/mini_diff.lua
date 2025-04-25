return {

  {
    'echasnovski/mini.diff',
    version = false, -- Use 'version = "*"‘ for the latest stable release
    event = 'VeryLazy',
    opts = {
      view = {
        style = 'sign', -- Options: 'sign' or 'number'
        signs = { add = '▎', change = '▎', delete = '' },
      },
    },
    keys = {
      {
        '<leader>GD',
        function()
          require('mini.diff').toggle_overlay(0)
        end,
        desc = 'Toggle mini.diff overlay',
      },
    },
  },
}
