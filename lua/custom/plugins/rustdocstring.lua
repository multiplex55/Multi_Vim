return {
  'nvim-treesitter/nvim-treesitter', -- make sure Treesitter is already installed
  ft = 'rust',
  config = function()
    vim.api.nvim_create_user_command('RustDocstring', function()
      require('rustdocstring').insert_docstring()
    end, {})
  end,
}
