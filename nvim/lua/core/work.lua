vim.cmd([[
  let g:gitdir = substitute(system("git rev-parse --show-toplevel 2>&1 | grep -v fatal:"), '\n', '', 'g')

  if g:gitdir != '' && isdirectory(g:gitdir) && index(split(&path, ","), g:gitdir) < 0
	exe "set path+=".g:gitdir."/**"
  endif
]])

vim.api.nvim_create_user_command('Format', function()
  local filename = vim.fn.expand '%:p'
  local cmd = 'silent !$codestylerPATH/bin/codestyler --config $codestylerPATH/default.clang-format -ans ' .. filename
  vim.cmd(cmd)
end, {})