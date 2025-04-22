local M = {}

M.switch_colorscheme = function()
  local themes = {
    'catppuccin',
    'tokyonight',
    'tokyonight-night',
    'tokyonight-moon',
    'tokyonight-day',
  }

  local original = vim.g.colors_name

  require('telescope.pickers')
    .new({}, {
      prompt_title = '🎨 Switch Colorscheme',
      finder = require('telescope.finders').new_table { results = themes },
      sorter = require('telescope.config').values.generic_sorter {},
      attach_mappings = function(_, map)
        local actions = require 'telescope.actions'
        local state = require 'telescope.actions.state'

        local preview = function()
          local entry = state.get_selected_entry()
          if entry then
            vim.cmd.colorscheme(entry.value)
          end
        end

        map('i', '<CR>', function(bufnr)
          preview()
          actions.close(bufnr)
        end)

        map('i', '<C-n>', function()
          actions.move_selection_next()
          preview()
        end)

        map('i', '<C-p>', function()
          actions.move_selection_previous()
          preview()
        end)

        map('i', '<Esc>', function()
          vim.cmd.colorscheme(original)
          actions.close()
        end)

        return true
      end,
    })
    :find()
end

return M
