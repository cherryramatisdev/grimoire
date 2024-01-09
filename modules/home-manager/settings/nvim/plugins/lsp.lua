require'lspconfig'.tsserver.setup {}
require'lspconfig'.nixd.setup {}
require'lspconfig'.rust_analyzer.setup {}
require'lspconfig'.hls.setup {}

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.bo[ev.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.cmd [[ command! Rename :lua vim.lsp.buf.rename() ]]
        vim.cmd [[ command! Fixit :lua vim.lsp.buf.code_action() ]]
        vim.cmd [[ command! References :lua vim.lsp.buf.references() ]]
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
