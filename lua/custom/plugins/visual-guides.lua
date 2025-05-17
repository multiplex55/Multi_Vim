return {
  -- Rainbow delimiters using Treesitter
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          rust = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          rust = 'rainbow-delimiters',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },

  -- Indentation guides

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPre',
    config = function()
      -- Add highlight defs above this line
      vim.cmd [[
      highlight default RainbowIndent1 guifg=#E06C75
      highlight default RainbowIndent2 guifg=#E5C07B
      highlight default RainbowIndent3 guifg=#98C379
      highlight default RainbowIndent4 guifg=#56B6C2
      highlight default RainbowIndent5 guifg=#61AFEF
      highlight default RainbowIndent6 guifg=#C678DD
      highlight default RainbowIndent7 guifg=#ABB2BF
    ]]

      require('ibl').setup {
        indent = {
          char = '│',
          tab_char = '│',
          highlight = {
            'RainbowIndent1',
            'RainbowIndent2',
            'RainbowIndent3',
            'RainbowIndent4',
            'RainbowIndent5',
            'RainbowIndent6',
            'RainbowIndent7',
          },
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          highlight = {
            'RainbowIndent1',
            'RainbowIndent2',
            'RainbowIndent3',
            'RainbowIndent4',
            'RainbowIndent5',
            'RainbowIndent6',
            'RainbowIndent7',
          },
        },
      }
    end,
  },
}
