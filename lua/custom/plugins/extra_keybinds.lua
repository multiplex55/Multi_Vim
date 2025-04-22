return {
  {
    vim.keymap.set('n', '<leader>npr', function()
      local dir_path = vim.fn.expand '%:p:h'
      local filename_no_ext = vim.fn.expand '%:t:r'
      local full_path_with_ext = vim.fn.expand '%:p'

      local cmd = string.format(':tabnew | term nim cpp -d:release -r --out:"%s\\bin\\%s" "%s"', dir_path, filename_no_ext, full_path_with_ext)
      vim.cmd(cmd)
    end, {
      desc = '[n]im c[p]p [r]un release',
    }),

    -- Which-Key group labels
    vim.keymap.set('n', '<leader>cc', '<Nop>', { desc = '[C]ode [C]argo' }),

    -- Rust-related commands under <leader>cc
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

  -- Window Management
  -- Move between windows
  vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = '[W]indows Left' }),
  vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = '[W]indows Down' }),
  vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = '[W]indows Up' }),
  vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = '[W]indows Right' }),

  -- Resize splits
  vim.keymap.set('n', '<leader>w<Left>', '<C-w><', { desc = '[W]indows Resize ←' }),
  vim.keymap.set('n', '<leader>w<Right>', '<C-w>>', { desc = '[W]indows Resize →' }),
  vim.keymap.set('n', '<leader>w<Up>', '<C-w>+', { desc = '[W]indows Resize ↑' }),
  vim.keymap.set('n', '<leader>w<Down>', '<C-w>-', { desc = '[W]indows Resize ↓' }),

  -- Split window
  vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = '[W]indows [V]ertical Split' }),
  vim.keymap.set('n', '<leader>wb', '<cmd>split<cr>', { desc = '[W]indows Horizontal Split' }),

  -- Window actions
  vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = '[W]indows Equalize Splits' }),
  vim.keymap.set('n', '<leader>wq', '<cmd>q<cr>', { desc = '[W]indows Close Split' }),
  vim.keymap.set('n', '<leader>wx', '<C-w>x', { desc = '[W]indows Swap Splits' }),
  vim.keymap.set('n', '<leader>wr', '<C-w>r', { desc = '[W]indows Rotate Splits' }),
  vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = '[W]indows Close Other Splits' }),

  --window picker
  vim.keymap.set('n', '<leader>wp', function()
    local picked = require('window-picker').pick_window()
    if picked then
      vim.api.nvim_set_current_win(picked)
    end
  end, { desc = '[W]indow [P]icker' }),

  --barbar tab navigatio- Buffer navigation
  vim.keymap.set('n', '<Tab>', '<cmd>BufferNext<cr>', { desc = '[T]ab Next' }),
  vim.keymap.set('n', '<S-Tab>', '<cmd>BufferPrevious<cr>', { desc = '[T]ab Previous' }),

  -- Buffer reordering
  vim.keymap.set('n', '<leader>tm', '<cmd>BufferMoveNext<cr>', { desc = '[T]ab Move right' }),
  vim.keymap.set('n', '<leader>tM', '<cmd>BufferMovePrevious<cr>', { desc = '[T]ab Move left' }),

  -- Buffer pin/unpin
  vim.keymap.set('n', '<leader>tp', '<cmd>BufferPin<cr>', { desc = '[T]ab [P]in' }),

  -- Buffer closing
  vim.keymap.set('n', '<leader>tq', '<cmd>BufferClose<cr>', { desc = '[T]ab [Q]uit' }),
  vim.keymap.set('n', '<leader>to', '<cmd>BufferCloseAllButCurrent<cr>', { desc = '[T]ab Close [O]thers' }),
  vim.keymap.set('n', '<leader>tl', '<cmd>BufferCloseBuffersLeft<cr>', { desc = '[T]ab Close Left' }),
  vim.keymap.set('n', '<leader>tr', '<cmd>BufferCloseBuffersRight<cr>', { desc = '[T]ab Close Right' }),

  -- Buffer picking
  vim.keymap.set('n', '<leader>tt', '<cmd>BufferPick<cr>', { desc = '[T]ab Pick (letter select)' }),

  -- Buffer ordering (sorting)
  vim.keymap.set('n', '<leader>tsd', '<cmd>BufferOrderByDirectory<cr>', { desc = '[T]ab Sort by [D]irectory' }),
  vim.keymap.set('n', '<leader>tsl', '<cmd>BufferOrderByLanguage<cr>', { desc = '[T]ab Sort by [L]anguage' }),

  -- Create a new tab
  vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<cr>', { desc = '[T]ab [N]ew' }),

  -- Soft delete (BufferDelete plugin optional, or close)
  vim.keymap.set('n', '<leader>td', '<cmd>bdelete<cr>', { desc = '[T]ab [D]elete Buffer' }),

  -- Force delete (for when buffers hang)
  vim.keymap.set('n', '<leader>tD', '<cmd>bdelete!<cr>', { desc = '[T]ab [D]elete Force' }),

  --Sessions Saving
  -- Manual session controls
  vim.keymap.set('n', '<leader>ssm', ':SessionSave<space>', { desc = '[S]ession [S]ave [M]anual Save' }),
  vim.keymap.set('n', '<leader>ssr', ':SessionRestore<space>', { desc = '[S]ession [S]ave [R]estore' }),
  vim.keymap.set('n', '<leader>ssd', ':SessionDelete<space>', { desc = '[S]ession [S]ave [D]elete' }),
}
