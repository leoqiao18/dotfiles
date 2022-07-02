local M = {}

function M.config()
  vim.cmd [[
    let g:dashboard_default_executive = 'telescope'
    let g:dashboard_custom_header = [
        \'          ▀████▀▄▄              ▄█ ',
        \'            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
        \'    ▄        █          ▀▀▀▀▄  ▄▀  ',
        \'   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
        \'  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
        \'  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
        \'   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
        \'    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
        \'   █   █  █      ▄▄           ▄▀   ',
        \]
    let g:dashboard_custom_footer = ['hi there!']
    let g:dashboard_custom_shortcut={
    \ 'last_session'       : 'SPC s l',
    \ 'find_history'       : 'SPC f r',
    \ 'find_file'          : 'SPC f f',
    \ 'new_file'           : 'SPC f n',
    \ 'change_colorscheme' : 'SPC u c',
    \ 'find_word'          : 'SPC f a',
    \ 'book_marks'         : 'SPC f b',
    \ }
  ]]
end

function M.plug(use)
  use {
    "glepnir/dashboard-nvim",
    config = function ()
      require("qnix.plugins.dashboard").config()
    end
  }
end

return M
