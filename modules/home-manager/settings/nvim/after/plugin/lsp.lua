local map = vim.api.nvim_set_keymap

-----------------------------------------------------------------------------
--    LSP
-----------------------------------------------------------------------------
local nvim_lsp = require'lspconfig'
local on_attach = function(client)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {})
    map('n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<cr>', {})
    vim.cmd [[ command! References execute "lua vim.lsp.buf.references()" ]]
    vim.cmd [[ command! Rename execute "lua vim.lsp.buf.rename()" ]]
    client.server_capabilities.semanticTokensProvider = nil
end

nvim_lsp.rust_analyzer.setup({
    on_attach = on_attach,
})

nvim_lsp.tsserver.setup({
    on_attach = on_attach,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false, 
        signs = false, 
        update_in_insert = false,
        underline = false,
        severity_sort = false,
    }
)
