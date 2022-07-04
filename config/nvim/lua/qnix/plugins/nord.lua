return {
  plug = function(use)
    use {
      "shaunsingh/nord.nvim",
      config = function()
        -- vim.g.tokyonight_style = "night"
        -- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
        vim.cmd [[colorscheme nord]]
      end,
    }
  end
}
