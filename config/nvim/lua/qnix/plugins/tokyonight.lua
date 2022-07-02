return {
  plug = function(use)
    use {
      "folke/tokyonight.nvim",
      config = function()
        vim.g.tokyonight_style = "night"
        vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
        vim.cmd [[colorscheme tokyonight]]
      end,
    }
  end
}
