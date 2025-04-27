local dap = require 'dap'

local mason_registry = require 'mason-registry'
local codelldb = mason_registry.get_package 'codelldb'
local extension_path = codelldb:get_install_path() .. '\\extension\\'
local codelldb_path = extension_path .. 'adapter\\codelldb.exe'
local liblldb_path = extension_path .. 'lldb\\bin\\liblldb.dll'

local cfg = require 'rustaceanvim.config'

vim.g.rustaceanvim = {
  dap = {
    adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}

dap.configurations.rust = {
  {
    name = 'Launch Rust (smart build)',
    type = 'codelldb', --rust
    request = 'launch',
    program = function()
      local cwd = vim.fn.getcwd()
      vim.fn.system 'cargo build'
      local exe = cwd .. '/target/debug/' .. vim.fn.fnamemodify(cwd, ':t')
      return exe
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- DAP-UI
require('dapui').setup()

-- Auto open/close dap-ui
dap.listeners.after.event_initialized['dapui_config'] = function()
  require('dapui').open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  require('dapui').close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  require('dapui').close()
end

-- DAP-VirtualText
require('nvim-dap-virtual-text').setup {
  enabled = true,
  commented = true,
}

-- Telescope integration
require('telescope').load_extension 'dap'

-- Custom Icons for Debugging
vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '⚠️', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🔵', texthl = '', linehl = '', numhl = '' })

-- Keybindings
local map = vim.keymap.set

map('n', '<leader>cdd', function()
  dap.continue()
end, { desc = '[C]ode [D]ebug Start/Continue' })
map('n', '<leader>cdt', function()
  dap.terminate()
end, { desc = '[C]ode [D]ebug Terminate' })
map('n', '<leader>cdb', function()
  dap.toggle_breakpoint()
end, { desc = '[C]ode [D]ebug Toggle Breakpoint' })
map('n', '<leader>cdB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = '[C]ode [D]ebug Set Breakpoint Condition' })
map('n', '<leader>cdo', function()
  dap.step_over()
end, { desc = '[C]ode [D]ebug Step Over' })
map('n', '<leader>cdi', function()
  dap.step_into()
end, { desc = '[C]ode [D]ebug Step Into' })
map('n', '<leader>cdu', function()
  dap.step_out()
end, { desc = '[C]ode [D]ebug Step Out' })
map('n', '<leader>cdr', function()
  dap.repl.open()
end, { desc = '[C]ode [D]ebug REPL Open' })
map('n', '<leader>cda', function()
  dap.attach()
end, { desc = '[C]ode [D]ebug Attach to Process' })
map('n', '<leader>cde', function()
  require('dap.ui.widgets').hover()
end, { desc = '[C]ode [D]ebug Evaluate Expression' })

-- Telescope DAP pickers
map('n', '<leader>cdf', '<cmd>Telescope dap frames<cr>', { desc = '[C]ode [D]ebug [F]rames' })
map('n', '<leader>cds', '<cmd>Telescope dap scopes<cr>', { desc = '[C]ode [D]ebug [S]copes' })
map('n', '<leader>cdp', '<cmd>Telescope dap list_breakpoints<cr>', { desc = '[C]ode [D]ebug [P]oints (breakpoints)' })
