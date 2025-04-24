-- Color switching
local M = {}

M.switch_colorscheme = function()
  local themes = {
    -- Existing
    'catppuccin',
    'tokyonight',
    'tokyonight-night',
    'tokyonight-moon',
    'tokyonight-day',
    'nord',
    'onedark',
    'carbonfox',
    'duskfox',
    'kanagawa',
    'kanagawa-wave',
    'kanagawa-dragon',
    'gruvbox-material',
    'github_dark',
    'material',
    'rose-pine',
    'rose-pine-moon',
    'oxocarbon',
    'nightfly',
    'falcon',
    'calvera-dark',
    'mellow',
    'mellifluous',
    'darkplus',
    'zenbones',
    'fluoromachine',
    'visual_studio_code',
    'vscode',
    'melange',
    'everforest',
    'zephyr',
    'sweetie',
    'ayu-mirage',
  }

  local original = vim.g.colors_name

  require('telescope.pickers')
    .new({
      layout_config = {
        width = 0.33,
        height = 0.5,
        prompt_position = 'top',
      },
      layout_strategy = 'vertical',
    }, {
      prompt_title = '🎨 Switch Colorscheme',
      finder = require('telescope.finders').new_table { results = themes },
      sorter = require('telescope.config').values.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        local actions = require 'telescope.actions'
        local state = require 'telescope.actions.state'

        local preview = function()
          local entry = state.get_selected_entry()
          if entry then
            pcall(vim.cmd.colorscheme, entry.value)
          end
        end

        -- Preview initial selection
        vim.defer_fn(preview, 0)

        -- Live preview on selection change
        map('i', '<Down>', function()
          actions.move_selection_next(prompt_bufnr)
          preview()
        end)
        map('i', '<Up>', function()
          actions.move_selection_previous(prompt_bufnr)
          preview()
        end)
        map('i', '<C-n>', function()
          actions.move_selection_next(prompt_bufnr)
          preview()
        end)
        map('i', '<C-p>', function()
          actions.move_selection_previous(prompt_bufnr)
          preview()
        end)

        -- Confirm selection
        map('i', '<CR>', function()
          actions.close(prompt_bufnr)
        end)

        -- Revert on cancel
        map('i', '<Esc>', function()
          pcall(vim.cmd.colorscheme, original)
          actions.close(prompt_bufnr)
        end)

        return true
      end,
    })
    :find()
end
return M
