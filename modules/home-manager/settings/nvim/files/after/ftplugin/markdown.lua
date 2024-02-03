vim.o.spell = true
vim.o.spelllang = 'en_gb,pt,es'
vim.o.wrap = true
vim.o.textwidth = 80
vim.o.syntax = 'on'

vim.keymap.set('n', '<leader>z', function ()
    vim.cmd [[ ZenMode | Pencil ]]
end, {})
-- set spell spelllang=en_gb,pt,es
-- set wrap
-- set textwidth=80
-- set syntax=on
--
-- nnoremap <leader>z <cmd>ZenMode | Pencil<CR>
