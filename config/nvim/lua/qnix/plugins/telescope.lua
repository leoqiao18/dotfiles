local M = {}

function M.config()
  require("telescope").setup {
    defaults = {
      sorting_strategy = "descending",
      layout_strategy = "vertical",
      file_ignore_patterns = {
        ".git",
      },
    },
  }

  require("telescope").load_extension "fzf"
  require("telescope").load_extension "file_browser"
end

function M.plug(use)
  use {
    "nvim-telescope/telescope.nvim",
    opt = true,
    event = "VimEnter",
    requires = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require("qnix.plugins.telescope").config()
    end,
  }
end

return M
