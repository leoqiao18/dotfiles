return {
  plug = function(use)
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
        }
      end
    }
  end
}
