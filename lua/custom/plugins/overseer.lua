return {
  {
    'stevearc/overseer.nvim',
    opts = {
      strategy = {
        'toggleterm', -- or "term"
      },
      task_list = {
        direction = 'bottom',
        min_height = 15,
        max_height = 25,
        default_detail = 1,
      },
      templates = {
        -- Define custom task templates here
        {
          name = 'Run Nim File',
          builder = function()
            local file = vim.fn.expand '%:p'
            return {
              cmd = { 'nim' },
              args = { 'compile', '--run', file },
              name = 'Run Nim File',
              components = { 'default' },
            }
          end,
          condition = {
            filetype = { 'nim' },
          },
        },
        {
          name = 'Run Rust Project',
          builder = function()
            return {
              cmd = { 'cargo' },
              args = { 'run' },
              name = 'Run Rust',
              components = { 'default' },
            }
          end,
          condition = {
            filetype = { 'rust' },
          },
        },
        {
          name = 'Run Lua File',
          builder = function()
            local file = vim.fn.expand '%:p'
            return {
              cmd = { 'lua' },
              args = { file },
              name = 'Run Lua File',
              components = { 'default' },
            }
          end,
          condition = {
            filetype = { 'lua' },
          },
        },
      },
    },
  },
}
