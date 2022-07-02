local M = {}

function M.project_files()
  local opts = {hidden=true}
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then
    require'telescope.builtin'.find_files(opts)
  end
end

function M.toggle_wrap()
  vim.cmd [[
    if &wrap
      echo "Wrap OFF"
      setlocal nowrap
      set virtualedit=all
      silent! nunmap <buffer> j
      silent! nunmap <buffer> k 
      silent! nunmap <buffer> <Home>
      silent! nunmap <buffer> <End>
    else
      echo "Wrap ON"
      setlocal wrap linebreak nolist
      set virtualedit=
      setlocal display+=lastline
      noremap <buffer> <silent> j gj
      noremap <buffer> <silent> k gk
      noremap <buffer> <silent> <Home> g<Home>
      noremap <buffer> <silent> <End>  g<End>
    endif
  ]]
end

return M
