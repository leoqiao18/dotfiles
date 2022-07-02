local M = {}

function M.config()
  vim.cmd [[
    let g:coqtail_auto_set_proof_diffs = 'on'
    let g:coqtail_nomap = 1
    let g:coqtail_noimap = 1

    " augroup CoqtailHighlights
    "   autocmd!
    "   autocmd ColorScheme *
    "     \  hi def CoqtailChecked ctermbg=236 guibg=#1f2231
    "     \| hi def CoqtailSent    ctermbg=237 guibg=#20303b
    " augroup END
    hi def CoqtailChecked ctermbg=236 guibg=#164846
    hi def CoqtailSent    ctermbg=237 guibg=#394b70
  ]]
end

function M.plug(use)
  use {
    "whonore/coqtail",
    config = function()
      require("qnix.plugins.coqtail").config()
    end
  }
end

return M
