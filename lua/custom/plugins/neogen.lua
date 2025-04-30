return {
  {
    'danymat/neogen',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('neogen').setup {
        snippet_engine = 'luasnip',
        enabled = true,
        languages = {
          rust = {
            template = {
              annotation_convention = 'rustdoc',
              custom = require 'custom.neogen-templates.rust',
            },
          },
        },
      }
    end,
    keys = {
      {
        '<leader>cD',
        function()
          require('neogen').generate {}
        end,
        desc = '[C]ode [D]oc (Generate Documentation)',
      },
    },
  },
}
