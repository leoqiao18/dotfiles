local M = {}

function M.config()
  require('nvim-treesitter.configs').setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "maintained",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = { },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      -- additional_vim_regex_highlighting = true,
    },

    require('nvim-ts-autotag').setup()
  }
end

function M.plug(use)
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-refactor",
      -- Use treesitter to refactor identifiers
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- Use treesitter to find motion text objects
      "nvim-treesitter/playground",
      -- Show treesitter state in split pane
      "folke/twilight.nvim",
      -- Dim inactive regions of code
      "danymat/neogen",
      -- Treesitter-powered doc-comment generator
      "windwp/nvim-ts-autotag",
      -- Use treesitter to autoclose and autorename html tag
    },
    run = ":TSUpdate",
    config = function()
      require("pokerus.plugins.treesitter").config()
    end
  }

  use {
    "lewis6991/spellsitter.nvim",
    -- Show spelling errors
    -- Note that somehow this plugin doesn't actually depend on nvim-treesitter
    config = function()
      require("spellsitter").setup {}
    end,
  }
end

return M
