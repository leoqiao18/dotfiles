local M = {}

function M.setup()
  vim.cmd [[
    autocmd FileType go setlocal noexpandtab tabstop=8 shiftwidth=8
    autocmd FileType make,cmake setlocal noexpandtab tabstop=8 shiftwidth=8
    autocmd FileType text,markdown setlocal spell spelllang=en_us
  ]]
end

return M
