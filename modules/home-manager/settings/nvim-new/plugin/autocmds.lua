vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "*",
  callback = function()
    vim.cmd [[ startinsert ]]
  end,
})

vim.api.nvim_create_autocmd({ "TermClose" }, {
  pattern = "*",
  callback = function()
    vim.cmd [[ execute 'bdelete! ' . expand('<abuf>') ]]
  end,
})
