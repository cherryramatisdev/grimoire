require'lspconfig'.tsserver.setup {}
require'lspconfig'.nixd.setup {}
require'lspconfig'.rust_analyzer.setup {}
require'lspconfig'.elixirls.setup {
    cmd = { vim.fn.expand('~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh') }
}
require'lspconfig'.hls.setup {}

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.bo[ev.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('i', '<C-o>', '<c-x><c-o>', opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.cmd [[ command! Rename :lua vim.lsp.buf.rename() ]]
        -- vim.cmd [[ command! Fixit :lua vim.lsp.buf.code_action() ]]

        vim.api.nvim_create_user_command('Fixit',
            function()
                local mode = vim.fn.mode()

                if mode == "v" then
                    vim.cmd("normal! gv")
                end

                vim.lsp.buf.code_action()

            end,
            { range = 0, nargs = 0 })

        vim.cmd [[ command! References :lua vim.lsp.buf.references() ]]
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
