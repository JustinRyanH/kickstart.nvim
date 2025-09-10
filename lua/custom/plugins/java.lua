vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.expandtab = true
  end,
})

return {}
