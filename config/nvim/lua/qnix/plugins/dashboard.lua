local M = {}

function M.config()
  local db = require('dashboard')

  db.custom_header = {
    '',
    '',
    '          ▀████▀▄▄              ▄█ ',
    '            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
    '    ▄        █          ▀▀▀▀▄  ▄▀  ',
    '   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
    '  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
    '  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
    '   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
    '    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
    '   █   █  █      ▄▄           ▄▀   ',
    '',
    '',
  }

  db.custom_center = {
    { icon = '  ',
      desc = 'Recently latest session                  ',
      shortcut = 'SPC s l',
      action = 'SessionLoad' },
    { icon = '  ',
      desc = 'Recently opened files                   ',
      action = 'Telescope oldfiles',
      shortcut = 'SPC f r' },
    { icon = '  ',
      desc = 'Find  File                              ',
      action = 'Telescope find_files find_command=rg,--hidden,--files',
      shortcut = 'SPC f f' },
    { icon = '  ',
      desc = 'File Browser                            ',
      action = 'Telescope file_browser',
      shortcut = 'SPC f b' },
    { icon = '  ',
      desc = 'Find  word                              ',
      action = 'Telescope live_grep',
      shortcut = 'SPC f /' },
    -- {icon = '  ',
    -- desc = 'Open Personal dotfiles                  ',
    -- action = 'Telescope dotfiles path=' .. home ..'/.dotfiles',
    -- shortcut = 'SPC f d'},
  }

  -- vim.cmd [[
  --   let g:dashboard_default_executive = 'telescope'
  --   let g:dashboard_custom_header = [
  --       \'          ▀████▀▄▄              ▄█ ',
  --       \'            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
  --       \'    ▄        █          ▀▀▀▀▄  ▄▀  ',
  --       \'   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
  --       \'  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
  --       \'  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
  --       \'   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
  --       \'    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
  --       \'   █   █  █      ▄▄           ▄▀   ',
  --       \]
  --   let g:dashboard_custom_footer = ['hi there!']
  --   let g:dashboard_custom_shortcut={
  --   \ 'last_session'       : 'SPC s l',
  --   \ 'find_history'       : 'SPC f r',
  --   \ 'find_file'          : 'SPC f f',
  --   \ 'new_file'           : 'SPC f n',
  --   \ 'change_colorscheme' : 'SPC u c',
  --   \ 'find_word'          : 'SPC f a',
  --   \ 'book_marks'         : 'SPC f b',
  --   \ }
  -- ]]
end

function M.plug(use)
  use {
    "glepnir/dashboard-nvim",
    config = function()
      require("qnix.plugins.dashboard").config()
    end
  }
end

return M
