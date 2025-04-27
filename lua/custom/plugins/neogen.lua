return {
  {
    'danymat/neogen',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('neogen').setup {
        snippet_engine = 'luasnip', -- you already have luasnip installed
        enabled = true,
        languages = {
          rust = {
            template = {
              annotation_convention = 'rustdoc', -- <-- use Rust style `///`
              custom = require 'custom.neogen-templates.rust', -- 🧠 custom template location
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
