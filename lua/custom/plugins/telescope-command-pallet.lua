return {

  {
    'LinArcX/telescope-command-palette.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telescope').load_extension 'command_palette'
    end,
  },
}
