return {
  {
    -- NIM
    vim.keymap.set('n', '<leader>npr', function()
      local dir_path = vim.fn.expand '%:p:h'
      local filename_no_ext = vim.fn.expand '%:t:r'
      local full_path_with_ext = vim.fn.expand '%:p'

      local cmd = string.format(':tabnew | term nim cpp -d:release -r --out:"%s\\bin\\%s" "%s"', dir_path, filename_no_ext, full_path_with_ext)
      vim.cmd(cmd)
    end, {
      desc = '[n]im c[p]p [r]un release',
    }),

    -- Rust-related commands under <leader>cc
    vim.keymap.set('n', '<leader>cc', '<Nop>', { desc = '[C]ode [C]argo' }),

    vim.keymap.set('n', '<leader>ccr', '<cmd>tabnew | term cargo run<cr>', { desc = '[C]ode [C]argo [R]un' }),
    vim.keymap.set('n', '<leader>ccR', '<cmd>tabnew | term cargo run --release<cr>', { desc = '[C]ode [C]argo Run --[R]elease' }),
    vim.keymap.set('n', '<leader>ccb', '<cmd>tabnew | term cargo build<cr>', { desc = '[C]ode [C]argo [B]uild' }),
    vim.keymap.set('n', '<leader>ccB', '<cmd>tabnew | term cargo build --release<cr>', { desc = '[C]ode [C]argo Build --[R]elease' }),
    vim.keymap.set('n', '<leader>cct', '<cmd>tabnew | term cargo test<cr>', { desc = '[C]ode [C]argo [T]est' }),
    vim.keymap.set('n', '<leader>ccC', '<cmd>tabnew | term cargo check<cr>', { desc = '[C]ode [C]argo [C]heck' }),
    vim.keymap.set('n', '<leader>ccc', '<cmd>tabnew | term cargo clean<cr>', { desc = '[C]ode [C]argo [C]lean' }),
    vim.keymap.set('n', '<leader>ccd', '<cmd>tabnew | term cargo doc --open<cr>', { desc = '[C]ode [C]argo [D]oc open' }),
    vim.keymap.set('n', '<leader>ccu', '<cmd>tabnew | term cargo update<cr>', { desc = '[C]ode [C]argo [U]pdate deps' }),
    vim.keymap.set('n', '<leader>ccf', '<cmd>tabnew | term cargo fmt<cr>', { desc = '[C]ode [C]argo [F]ormat code' }),
    vim.keymap.set('n', '<leader>ccl', '<cmd>tabnew | term cargo clippy<cr>', { desc = '[C]ode [C]argo C[L]ippy lint' }),

    -- Increase font size
    vim.keymap.set('n', '<C-=>', function()
      local font = vim.o.guifont
      local name, size = string.match(font, '([^:]+):h(%d+)')
      size = tonumber(size) + 1
      vim.o.guifont = name .. ':h' .. size
    end),

    -- Decrease font size
    vim.keymap.set('n', '<C-->', function()
      local font = vim.o.guifont
      local name, size = string.match(font, '([^:]+):h(%d+)')
      size = tonumber(size) - 1
      vim.o.guifont = name .. ':h' .. size
    end),
  },

  -- Format Buffer
  vim.keymap.set('n', '<leader>fb', function()
    require('conform').format {
      async = true,
      lsp_fallback = 'fallback',
    }
  end, { desc = '[F]ormat buffer' }),

  -- Window Management
  -- Move between windows
  vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = '[w]indows Left' }),
  vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = '[w]indows Down' }),
  vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = '[w]indows Up' }),
  vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = '[w]indows Right' }),

  -- Resize splits
  vim.keymap.set('n', '<leader>w<Left>', '<C-w><', { desc = '[w]indows Resize ←' }),
  vim.keymap.set('n', '<leader>w<Right>', '<C-w>>', { desc = '[w]indows Resize →' }),
  vim.keymap.set('n', '<leader>w<Up>', '<C-w>+', { desc = '[w]indows Resize ↑' }),
  vim.keymap.set('n', '<leader>w<Down>', '<C-w>-', { desc = '[w]indows Resize ↓' }),

  -- Split window
  vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = '[w]indows [V]ertical Split' }),
  vim.keymap.set('n', '<leader>wb', '<cmd>split<cr>', { desc = '[w]indows Horizontal Split' }),

  -- Window actions
  vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = '[w]indows Equalize Splits' }),
  vim.keymap.set('n', '<leader>wq', '<cmd>q<cr>', { desc = '[w]indows Close Split' }),
  vim.keymap.set('n', '<leader>wx', '<C-w>x', { desc = '[w]indows Swap Splits' }),
  vim.keymap.set('n', '<leader>wr', '<C-w>r', { desc = '[w]indows Rotate Splits' }),
  vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = '[w]indows Close Other Splits' }),

  --window picker
  vim.keymap.set('n', '<leader>wp', function()
    local picked = require('window-picker').pick_window()
    if picked then
      vim.api.nvim_set_current_win(picked)
    end
  end, { desc = '[w]indow [p]icker' }),

  --barbar tab navigatio- Buffer navigation
  vim.keymap.set('n', '<Tab>', '<cmd>BufferNext<cr>', { desc = '[t]ab Next' }),
  vim.keymap.set('n', '<S-Tab>', '<cmd>BufferPrevious<cr>', { desc = '[t]ab Previous' }),

  -- Buffer reordering
  vim.keymap.set('n', '<leader>tm', '<cmd>BufferMoveNext<cr>', { desc = '[t]ab Move right' }),
  vim.keymap.set('n', '<leader>tM', '<cmd>BufferMovePrevious<cr>', { desc = '[t]ab Move left' }),

  -- Buffer pin/unpin
  vim.keymap.set('n', '<leader>tp', '<cmd>BufferPin<cr>', { desc = '[t]ab [P]in' }),

  -- Buffer closing
  vim.keymap.set('n', '<leader>tq', '<cmd>BufferClose<cr>', { desc = '[t]ab [Q]uit' }),
  vim.keymap.set('n', '<leader>to', '<cmd>BufferCloseAllButCurrent<cr>', { desc = '[t]ab Close [O]thers' }),
  vim.keymap.set('n', '<leader>tl', '<cmd>BufferCloseBuffersLeft<cr>', { desc = '[t]ab Close Left' }),
  vim.keymap.set('n', '<leader>tr', '<cmd>BufferCloseBuffersRight<cr>', { desc = '[t]ab Close Right' }),

  -- Buffer picking
  vim.keymap.set('n', '<leader>tt', '<cmd>BufferPick<cr>', { desc = '[t]ab Pick (letter select)' }),

  -- Buffer ordering (sorting)
  vim.keymap.set('n', '<leader>tsd', '<cmd>BufferOrderByDirectory<cr>', { desc = '[t]ab Sort by [D]irectory' }),
  vim.keymap.set('n', '<leader>tsl', '<cmd>BufferOrderByLanguage<cr>', { desc = '[t]ab Sort by [L]anguage' }),

  -- Create a new tab
  vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<cr>', { desc = '[t]ab [N]ew' }),

  -- Close a tab
  vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<cr>', { desc = '[t]ab [c]lose' }),

  -- Soft delete (BufferDelete plugin optional, or close)
  vim.keymap.set('n', '<leader>td', '<cmd>bdelete<cr>', { desc = '[t]ab [D]elete Buffer' }),

  -- Force delete (for when buffers hang)
  vim.keymap.set('n', '<leader>tD', '<cmd>bdelete!<cr>', { desc = '[t]ab [D]elete Force' }),

  --Sessions Saving
  -- Manual session controls
  vim.keymap.set('n', '<leader>ssm', ':SessionSave<space>', { desc = '[s]ession [s]ave [M]anual Save' }),
  vim.keymap.set('n', '<leader>ssr', ':SessionRestore<space>', { desc = '[s]ession [s]ave [R]estore' }),
  vim.keymap.set('n', '<leader>ssd', ':SessionDelete<space>', { desc = '[s]ession [s]ave [D]elete' }),

  --Theme Switching
  vim.keymap.set('n', '<leader>Ut', function()
    require('custom.utils').switch_colorscheme()
  end, { desc = '[U]I [t]heme Switcher' }),

  --TABS

  -- Insert 4 spaces when pressing Tab in insert mode
  vim.keymap.set('i', '<Tab>', function()
    return string.rep(' ', vim.bo.softtabstop)
  end, { expr = true, desc = 'Insert 4 spaces' }),

  vim.keymap.set('i', '<S-Tab>', function()
    local col = vim.fn.col '.' -- current column (1-based)
    local line = vim.fn.getline '.' -- current line

    if col > 1 then
      local start_col = math.max(1, col - 4)
      local indent = line:sub(start_col, col - 1)

      if indent == '    ' then
        return '<BS><BS><BS><BS>'
      end
    end

    return ''
  end, { expr = true, desc = 'Unindent 4 spaces' }),

  -- LuaSnip jump forward
  vim.keymap.set({ 'i', 's' }, '<C-j>', function()
    local ls = require 'luasnip'
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { desc = 'LuaSnip jump forward' }),

  -- LuaSnip jump backward
  vim.keymap.set({ 'i', 's' }, '<C-k>', function()
    local ls = require 'luasnip'
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { desc = 'LuaSnip jump backward' }),

  vim.keymap.set('n', '<leader>dd', function()
    Snacks.dashboard()
  end, { desc = '[D]ashboard [D]isplay snacks' }),

  -- GIT and git diff
  vim.keymap.set('n', '<leader>Gn', function()
    require('neogit').open()
  end, { desc = '[G]IT [n]eogit' }),

  vim.keymap.set('n', '<leader>Gd', function()
    require('diffview').open()
  end, { desc = '[G]IT [d]iffview' }),

  vim.keymap.set('n', '<leader>GD', function()
    require('mini.diff').open()
  end, { desc = '[G]IT [D]iff Overlay' }),

  -- HOP - EasyMotion-style navigation
  vim.keymap.set('n', '<leader>hw', function()
    require('hop').hint_words()
  end, { desc = '[h]op [w]ords' }),

  vim.keymap.set('n', '<leader>hl', function()
    require('hop').hint_lines()
  end, { desc = '[h]op [l]ines' }),

  vim.keymap.set('n', '<leader>hc', function()
    require('hop').hint_char1()
  end, { desc = '[h]op [c]har 1' }),

  vim.keymap.set('n', '<leader>hC', function()
    require('hop').hint_char2()
  end, { desc = '[h]op [C]har 2' }),

  -- Hop to word across all windows
  vim.keymap.set('n', '<leader>hw', function()
    require('hop').hint_words { multi_windows = true }
  end, { desc = '[h]op [w]ords (all windows)' }),

  -- Hop to line across all windows
  vim.keymap.set('n', '<leader>hL', function()
    require('hop').hint_lines { multi_windows = true }
  end, { desc = '[h]op [L]ines (all windows)' }),

  -- Hop to pattern (search-like)
  vim.keymap.set('n', '<leader>hp', function()
    require('hop').hint_patterns()
  end, { desc = '[h]op to [p]attern' }),

  -- Visual mode: Hop to word
  vim.keymap.set('v', '<leader>hW', function()
    require('hop').hint_words()
  end, { desc = '[h]op [W]ords (visual)' }),

  -- Yank after hopping to word (insert-mode like behavior)
  vim.keymap.set('n', '<leader>hy', function()
    local hop = require 'hop'
    hop.hint_words {
      callback = function(node)
        vim.api.nvim_win_set_cursor(0, { node.line + 1, node.column })
        vim.cmd 'normal! yw'
      end,
    }
  end, { desc = '[h]op [Y]ank word' }),

  vim.keymap.set('n', '<leader>hh', function()
    require('hop').hint_anywhere()
  end, { desc = '[h]op Anyw[h]ere (visual)' }),

  -- Debugging
  vim.keymap.set('n', '<F5>', function()
    require('dap').continue()
  end, { desc = 'Start/Continue Debugging' }),

  vim.keymap.set('n', '<F10>', function()
    require('dap').step_over()
  end, { desc = 'Step Over' }),

  vim.keymap.set('n', '<F11>', function()
    require('dap').step_into()
  end, { desc = 'Step Into' }),

  vim.keymap.set('n', '<F12>', function()
    require('dap').step_out()
  end, { desc = 'Step Out' }),

  vim.keymap.set('n', '<leader>cdb', function()
    require('dap').toggle_breakpoint()
  end, { desc = '[C]ode [D]ebug Toggle [B]reakpoint' }),

  vim.keymap.set('n', '<leader>cdr', function()
    require('dap').repl.open()
  end, { desc = '[C]ode [D]ebug [R]EPL' }),
  -- vim lspsaga hover documentation
  -- Hover documentation
  vim.keymap.set('n', 'K', function()
    vim.cmd 'Lspsaga hover_doc'
  end, { desc = 'Show Hover Doc' }),

  -- Overseer keybinds under <leader>o
  vim.keymap.set('n', '<leader>oo', '<cmd>OverseerToggle<cr>', { desc = '[O]verseer [O]pen Task List' }),
  vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<cr>', { desc = '[O]verseer [R]un Task' }),
  vim.keymap.set('n', '<leader>ot', '<cmd>OverseerTaskAction<cr>', { desc = '[O]verseer Task Ac[t]ion' }),
  vim.keymap.set('n', '<leader>oa', '<cmd>OverseerQuickAction<cr>', { desc = '[O]verseer [A]ction (Quick)' }),
  vim.keymap.set('n', '<leader>oc', '<cmd>OverseerClearCache<cr>', { desc = '[O]verseer [C]lear Cache' }),
  vim.keymap.set('n', '<leader>os', '<cmd>OverseerSaveBundle<cr>', { desc = '[O]verseer [S]ave Task Bundle' }),
  vim.keymap.set('n', '<leader>ol', '<cmd>OverseerLoadBundle<cr>', { desc = '[O]verseer [L]oad Task Bundle' }),
  vim.keymap.set('n', '<leader>od', '<cmd>OverseerDeleteBundle<cr>', { desc = '[O]verseer [D]elete Task Bundle' }),
  vim.keymap.set('n', '<leader>oq', '<cmd>OverseerQuickAction<cr>', { desc = '[O]verseer [Q]uick Action' }),
  vim.keymap.set('n', '<leader>ob', '<cmd>OverseerBuild<cr>', { desc = '[O]verseer [B]uild Tasks' }),

  --Telescope file browser
  vim.keymap.set('n', '<space>sb', ':Telescope file_browser path=%":p:h select_buffer=true<CR>', { desc = '[S]earch file [B]rowser' }),

  -- Nvim Spectre

  vim.keymap.set('n', '<leader>srs', function()
    require('spectre').toggle()
  end, { desc = '[s]earch [r]eplace [s]pectre' }),

  vim.keymap.set('n', '<leader>srw', function()
    require('spectre').open_visual { select_word = true }
  end, { desc = '[s]earch [r]eplace Spectre visual under [w]ord' }),

  vim.keymap.set('v', '<leader>srv', function()
    require('spectre').open_visual()
  end, { desc = '[s]earch [r]eplace Spectre [v]isual' }),

  vim.keymap.set('n', '<leader>src', function()
    require('spectre').open_file_search()
  end, { desc = '[s]earch [r]eplace Spectre [c]urrent File' }),

  -- Muren (Find & Replace)
  vim.keymap.set('n', '<leader>mt', '<cmd>MurenToggle<cr>', { desc = '[m]uren [t]oggle UI' }),
  vim.keymap.set('n', '<leader>mo', '<cmd>MurenOpen<cr>', { desc = '[m]uren [o]pen UI' }),
  vim.keymap.set('n', '<leader>mw', function()
    local word = vim.fn.expand '<cword>'
    vim.cmd 'MurenOpen'
    vim.defer_fn(function()
      vim.api.nvim_feedkeys(word, 'n', false)
    end, 50)
  end, { desc = '[m]uren Search [w]ord' }),
}
