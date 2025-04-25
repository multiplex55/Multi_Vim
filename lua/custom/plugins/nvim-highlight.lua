return {
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'VeryLazy',
    opts = {
      render = 'background', -- options: 'background', 'foreground', 'virtual'
      enable_named_colors = true, -- e.g., "red", "green"
      enable_tailwind = true, -- highlight Tailwind classes like "bg-red-500"
    },
  },
}
