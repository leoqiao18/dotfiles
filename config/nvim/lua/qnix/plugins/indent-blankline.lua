return {
  plug = function(use)
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require('indent_blankline').setup {
          use_treesitter = true,
          show_current_context = true,
          show_current_context_start = false,
          show_first_indent_level = false,
          filetype_exclude = { "help", "dashboard", "packer", "norg", },
          buftype_exclude = { "terminal", },
        }
      end
    }
  end
}
